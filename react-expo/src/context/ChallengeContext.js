import React, { createContext, useContext, useEffect, useMemo, useState } from "react";
import { HABITS } from "../constants/challenge";
import { getDateKey, parseDateKey } from "../utils/date";
import { loadChallengeState, saveChallengeState } from "../storage/challengeStorage";

const ChallengeContext = createContext(null);

function buildEmptyEntry(dateKey) {
  const checklist = HABITS.reduce((accumulator, habit) => {
    accumulator[habit.key] = false;
    return accumulator;
  }, {});

  return {
    dateKey,
    checklist,
    photoUri: null,
    updatedAt: new Date().toISOString(),
  };
}

export function ChallengeProvider({ children }) {
  const [state, setState] = useState({
    startDate: null,
    entries: {},
  });
  const [isReady, setIsReady] = useState(false);

  useEffect(() => {
    async function bootstrap() {
      const stored = await loadChallengeState();
      setState(stored);
      setIsReady(true);
    }

    bootstrap();
  }, []);

  useEffect(() => {
    if (!isReady) {
      return;
    }

    saveChallengeState(state);
  }, [isReady, state]);

  const value = useMemo(() => {
    const getEntry = (dateKey = getDateKey()) => state.entries[dateKey] ?? buildEmptyEntry(dateKey);

    const setStartDate = (date) => {
      setState((current) => ({
        ...current,
        startDate: getDateKey(date),
      }));
    };

    const toggleHabit = (dateKey, habitKey) => {
      setState((current) => {
        const entry = current.entries[dateKey] ?? buildEmptyEntry(dateKey);
        return {
          ...current,
          entries: {
            ...current.entries,
            [dateKey]: {
              ...entry,
              checklist: {
                ...entry.checklist,
                [habitKey]: !entry.checklist[habitKey],
              },
              updatedAt: new Date().toISOString(),
            },
          },
        };
      });
    };

    const setPhoto = (dateKey, photoUri) => {
      setState((current) => {
        const entry = current.entries[dateKey] ?? buildEmptyEntry(dateKey);
        return {
          ...current,
          entries: {
            ...current.entries,
            [dateKey]: {
              ...entry,
              photoUri,
              checklist: {
                ...entry.checklist,
                photo: Boolean(photoUri),
              },
              updatedAt: new Date().toISOString(),
            },
          },
        };
      });
    };

    const resetChallenge = () => {
      setState({
        startDate: null,
        entries: {},
      });
    };

    const photoEntries = Object.values(state.entries)
      .filter((entry) => entry.photoUri)
      .sort((a, b) => parseDateKey(b.dateKey) - parseDateKey(a.dateKey));

    return {
      ...state,
      isReady,
      getEntry,
      setStartDate,
      toggleHabit,
      setPhoto,
      resetChallenge,
      photoEntries,
    };
  }, [isReady, state]);

  return <ChallengeContext.Provider value={value}>{children}</ChallengeContext.Provider>;
}

export function useChallenge() {
  const context = useContext(ChallengeContext);

  if (!context) {
    throw new Error("useChallenge must be used within a ChallengeProvider");
  }

  return context;
}
