import React, { useMemo } from "react";
import { ScrollView, StyleSheet, Text, View } from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { CHALLENGE_LENGTH, HABITS, NATURE_BACKGROUNDS } from "../constants/challenge";
import { useChallenge } from "../context/ChallengeContext";
import {
  formatLongDate,
  formatShortDate,
  getChallengeDates,
  getChallengeDay,
  parseDateKey,
} from "../utils/date";
import ScreenBackground from "../components/ScreenBackground";
import HeroHeader from "../components/HeroHeader";
import GlassCard from "../components/GlassCard";
import ProgressBar from "../components/ProgressBar";
import { palette } from "../theme/palette";

function ProgressPill({ label, value }) {
  return (
    <View style={styles.pill}>
      <Text style={styles.pillLabel}>{label}</Text>
      <Text style={styles.pillValue}>{value}</Text>
    </View>
  );
}

export default function ProgressScreen() {
  const { startDate, getEntry } = useChallenge();

  const summary = useMemo(() => {
    if (!startDate) {
      return null;
    }

    const challengeStart = parseDateKey(startDate);
    const dates = getChallengeDates(challengeStart);
    const days = dates.map((date, index) => {
      const entry = getEntry(
        `${date.getFullYear()}-${`${date.getMonth() + 1}`.padStart(2, "0")}-${`${date.getDate()}`.padStart(2, "0")}`
      );
      const completedCount = HABITS.filter((habit) => entry.checklist[habit.key]).length;
      return {
        id: index + 1,
        date,
        completedCount,
        progress: completedCount / HABITS.length,
      };
    });

    const finishedDays = days.filter((day) => day.completedCount === HABITS.length).length;
    return {
      currentDay: getChallengeDay(challengeStart),
      overallProgress: getChallengeDay(challengeStart) / CHALLENGE_LENGTH,
      finishedDays,
      days,
    };
  }, [getEntry, startDate]);

  return (
    <ScreenBackground image={NATURE_BACKGROUNDS.progress}>
      <SafeAreaView style={styles.safeArea}>
        <ScrollView contentContainerStyle={styles.content} showsVerticalScrollIndicator={false}>
          <HeroHeader
            eyebrow="Progress"
            title={summary ? `Keep the streak honest` : "No challenge in motion"}
            subtitle={
              summary
                ? `${summary.finishedDays} fully completed day${summary.finishedDays === 1 ? "" : "s"} so far.`
                : "Set a start date on the home screen to unlock your 75-day view."
            }
            rightContent={
              summary ? <ProgressPill label="Day" value={`${summary.currentDay}/${CHALLENGE_LENGTH}`} /> : null
            }
          />

          {summary ? (
            <>
              <GlassCard style={styles.summaryCard}>
                <Text style={styles.sectionTitle}>Challenge completion</Text>
                <ProgressBar label="75-day timeline" progress={summary.overallProgress} />
                <View style={styles.summaryRow}>
                  <View>
                    <Text style={styles.metricLabel}>Started</Text>
                    <Text style={styles.metricValue}>{formatShortDate(parseDateKey(startDate))}</Text>
                  </View>
                  <View>
                    <Text style={styles.metricLabel}>Perfect days</Text>
                    <Text style={styles.metricValue}>{summary.finishedDays}</Text>
                  </View>
                </View>
              </GlassCard>

              <GlassCard>
                <Text style={styles.sectionTitle}>Day-by-day view</Text>
                <Text style={styles.sectionSubtitle}>Each card reflects that day’s completed habits.</Text>
                {summary.days.map((day) => (
                  <View key={day.id} style={styles.dayRow}>
                    <View style={styles.dayInfo}>
                      <Text style={styles.dayNumber}>Day {day.id}</Text>
                      <Text style={styles.dayDate}>{formatLongDate(day.date)}</Text>
                    </View>
                    <View style={styles.dayMeta}>
                      <Text style={styles.dayCount}>
                        {day.completedCount}/{HABITS.length}
                      </Text>
                      <View style={styles.miniTrack}>
                        <View style={[styles.miniFill, { width: `${day.progress * 100}%` }]} />
                      </View>
                    </View>
                  </View>
                ))}
              </GlassCard>
            </>
          ) : (
            <GlassCard>
              <Text style={styles.emptyTitle}>Challenge timeline will appear here.</Text>
              <Text style={styles.emptyBody}>
                Pick your start date first. After that, each day’s checklist will feed the streak view automatically.
              </Text>
            </GlassCard>
          )}
        </ScrollView>
      </SafeAreaView>
    </ScreenBackground>
  );
}

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
  },
  content: {
    padding: 20,
    paddingBottom: 120,
    gap: 18,
  },
  pill: {
    minWidth: 84,
    paddingVertical: 14,
    paddingHorizontal: 12,
    borderRadius: 20,
    backgroundColor: "rgba(49,92,61,0.12)",
    alignItems: "center",
  },
  pillLabel: {
    fontSize: 11,
    color: palette.stone,
    fontWeight: "700",
    letterSpacing: 1,
    textTransform: "uppercase",
  },
  pillValue: {
    marginTop: 6,
    fontSize: 20,
    color: palette.forest,
    fontWeight: "800",
  },
  summaryCard: {
    gap: 18,
  },
  sectionTitle: {
    fontSize: 20,
    fontWeight: "800",
    color: palette.ink,
  },
  sectionSubtitle: {
    marginTop: 4,
    marginBottom: 14,
    color: palette.stone,
    fontSize: 14,
  },
  summaryRow: {
    flexDirection: "row",
    justifyContent: "space-between",
  },
  metricLabel: {
    fontSize: 12,
    color: palette.stone,
    textTransform: "uppercase",
    letterSpacing: 1,
    marginBottom: 4,
  },
  metricValue: {
    fontSize: 18,
    color: palette.ink,
    fontWeight: "800",
  },
  dayRow: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    gap: 12,
    paddingVertical: 14,
    borderBottomWidth: 1,
    borderBottomColor: palette.line,
  },
  dayInfo: {
    flex: 1,
  },
  dayNumber: {
    fontSize: 16,
    fontWeight: "800",
    color: palette.ink,
    marginBottom: 4,
  },
  dayDate: {
    fontSize: 13,
    color: palette.stone,
  },
  dayMeta: {
    width: 88,
    alignItems: "flex-end",
    gap: 8,
  },
  dayCount: {
    fontSize: 13,
    fontWeight: "800",
    color: palette.forest,
  },
  miniTrack: {
    width: "100%",
    height: 8,
    borderRadius: 999,
    backgroundColor: "rgba(49,92,61,0.10)",
    overflow: "hidden",
  },
  miniFill: {
    height: "100%",
    backgroundColor: palette.moss,
    borderRadius: 999,
  },
  emptyTitle: {
    fontSize: 20,
    lineHeight: 28,
    fontWeight: "800",
    color: palette.ink,
    marginBottom: 8,
  },
  emptyBody: {
    color: palette.stone,
    fontSize: 15,
    lineHeight: 22,
  },
});
