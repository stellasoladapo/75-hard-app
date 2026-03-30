import React, { useMemo, useState } from "react";
import {
  ActivityIndicator,
  Platform,
  Pressable,
  ScrollView,
  StyleSheet,
  Text,
  View,
} from "react-native";
import DateTimePicker from "@react-native-community/datetimepicker";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import { HABITS, NATURE_BACKGROUNDS } from "../constants/challenge";
import { useChallenge } from "../context/ChallengeContext";
import { formatLongDate, getChallengeDay, getDateKey, parseDateKey } from "../utils/date";
import { getDailyAffirmation } from "../utils/affirmation";
import ScreenBackground from "../components/ScreenBackground";
import HeroHeader from "../components/HeroHeader";
import GlassCard from "../components/GlassCard";
import ChecklistItem from "../components/ChecklistItem";
import AffirmationCard from "../components/AffirmationCard";
import ProgressBar from "../components/ProgressBar";
import { palette } from "../theme/palette";

function DayBadge({ label, value }) {
  return (
    <View style={styles.dayBadge}>
      <Text style={styles.dayBadgeLabel}>{label}</Text>
      <Text style={styles.dayBadgeValue}>{value}</Text>
    </View>
  );
}

export default function HomeScreen() {
  const { isReady, startDate, getEntry, setStartDate, toggleHabit } = useChallenge();
  const [showPicker, setShowPicker] = useState(false);
  const todayKey = getDateKey();
  const todayEntry = getEntry(todayKey);
  const selectedDate = startDate ? parseDateKey(startDate) : new Date();

  const completedHabits = HABITS.filter((habit) => todayEntry.checklist[habit.key]).length;
  const dailyProgress = completedHabits / HABITS.length;
  const challengeDay = startDate ? getChallengeDay(selectedDate) : 0;
  const affirmation = useMemo(() => getDailyAffirmation(), []);

  const handleDateChange = (_, date) => {
    if (Platform.OS !== "ios") {
      setShowPicker(false);
    }

    if (date) {
      setStartDate(date);
    }
  };

  if (!isReady) {
    return (
      <ScreenBackground image={NATURE_BACKGROUNDS.home}>
        <SafeAreaView style={styles.loaderWrap}>
          <ActivityIndicator size="large" color={palette.forest} />
        </SafeAreaView>
      </ScreenBackground>
    );
  }

  return (
    <ScreenBackground image={NATURE_BACKGROUNDS.home}>
      <SafeAreaView style={styles.safeArea}>
        <ScrollView contentContainerStyle={styles.content} showsVerticalScrollIndicator={false}>
          <HeroHeader
            eyebrow="75 Hard Tracker"
            title={startDate ? `Day ${challengeDay || 1}` : "Start your 75 days"}
            subtitle={
              startDate
                ? `${formatLongDate(new Date())} • Build proof with every checkbox.`
                : "Choose your challenge start date and lock in the first day."
            }
            rightContent={
              startDate ? (
                <DayBadge label="Today" value={`${Math.round(dailyProgress * 100)}%`} />
              ) : (
                <Ionicons name="leaf" size={36} color={palette.moss} />
              )
            }
          />

          <GlassCard style={styles.startCard}>
            <View style={styles.cardHeader}>
              <Text style={styles.cardTitle}>Challenge start date</Text>
              <Pressable style={styles.secondaryButton} onPress={() => setShowPicker(true)}>
                <Ionicons name="calendar-outline" size={16} color={palette.forest} />
                <Text style={styles.secondaryButtonText}>
                  {startDate ? formatLongDate(selectedDate) : "Pick a date"}
                </Text>
              </Pressable>
            </View>
            <Text style={styles.bodyText}>
              Your 75-day timeline begins from the selected date and today’s checklist is saved locally on this device.
            </Text>
            {showPicker ? (
              <DateTimePicker
                value={selectedDate}
                mode="date"
                display={Platform.OS === "ios" ? "inline" : "default"}
                maximumDate={new Date()}
                onChange={handleDateChange}
              />
            ) : null}
          </GlassCard>

          <GlassCard>
            <Text style={styles.sectionTitle}>Today’s checklist</Text>
            <Text style={styles.sectionSubtitle}>{formatLongDate(new Date())}</Text>
            <View style={styles.progressWrap}>
              <ProgressBar label="Daily progress" progress={dailyProgress} />
            </View>
            <View style={styles.listWrap}>
              {HABITS.map((habit) => (
                <ChecklistItem
                  key={habit.key}
                  title={habit.title}
                  subtitle={habit.subtitle}
                  checked={todayEntry.checklist[habit.key]}
                  onPress={() => toggleHabit(todayKey, habit.key)}
                />
              ))}
            </View>
          </GlassCard>

          <AffirmationCard quote={affirmation} />
        </ScrollView>
      </SafeAreaView>
    </ScreenBackground>
  );
}

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
  },
  loaderWrap: {
    flex: 1,
    alignItems: "center",
    justifyContent: "center",
  },
  content: {
    padding: 20,
    paddingBottom: 120,
    gap: 18,
  },
  dayBadge: {
    minWidth: 76,
    paddingVertical: 14,
    paddingHorizontal: 12,
    borderRadius: 20,
    backgroundColor: "rgba(49,92,61,0.12)",
    alignItems: "center",
  },
  dayBadgeLabel: {
    fontSize: 11,
    textTransform: "uppercase",
    letterSpacing: 1,
    color: palette.stone,
    fontWeight: "700",
  },
  dayBadgeValue: {
    marginTop: 6,
    fontSize: 22,
    color: palette.forest,
    fontWeight: "800",
  },
  startCard: {
    gap: 12,
  },
  cardHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    gap: 12,
  },
  cardTitle: {
    fontSize: 18,
    fontWeight: "800",
    color: palette.ink,
    flex: 1,
  },
  secondaryButton: {
    flexDirection: "row",
    alignItems: "center",
    gap: 8,
    backgroundColor: "rgba(169,195,160,0.18)",
    paddingVertical: 10,
    paddingHorizontal: 12,
    borderRadius: 999,
  },
  secondaryButtonText: {
    color: palette.forest,
    fontWeight: "700",
    fontSize: 13,
  },
  bodyText: {
    color: palette.stone,
    fontSize: 14,
    lineHeight: 21,
  },
  sectionTitle: {
    fontSize: 21,
    fontWeight: "800",
    color: palette.ink,
  },
  sectionSubtitle: {
    marginTop: 4,
    marginBottom: 16,
    color: palette.stone,
    fontSize: 14,
  },
  progressWrap: {
    marginBottom: 18,
  },
  listWrap: {
    marginTop: 6,
  },
});
