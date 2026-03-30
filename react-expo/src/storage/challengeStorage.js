import AsyncStorage from "@react-native-async-storage/async-storage";

const STORAGE_KEY = "seventy-five-hard-tracker";

export async function loadChallengeState() {
  const raw = await AsyncStorage.getItem(STORAGE_KEY);
  if (!raw) {
    return {
      startDate: null,
      entries: {},
    };
  }

  try {
    const parsed = JSON.parse(raw);
    return {
      startDate: parsed.startDate ?? null,
      entries: parsed.entries ?? {},
    };
  } catch {
    return {
      startDate: null,
      entries: {},
    };
  }
}

export async function saveChallengeState(state) {
  await AsyncStorage.setItem(STORAGE_KEY, JSON.stringify(state));
}
