import React from "react";
import { StyleSheet, Text, View } from "react-native";
import { Ionicons } from "@expo/vector-icons";
import GlassCard from "./GlassCard";
import { palette } from "../theme/palette";

export default function AffirmationCard({ quote }) {
  return (
    <GlassCard style={styles.card}>
      <View style={styles.header}>
        <Ionicons name="sunny-outline" size={18} color={palette.earth} />
        <Text style={styles.label}>Daily Affirmation</Text>
      </View>
      <Text style={styles.quote}>{quote}</Text>
    </GlassCard>
  );
}

const styles = StyleSheet.create({
  card: {
    gap: 10,
  },
  header: {
    flexDirection: "row",
    alignItems: "center",
    gap: 8,
  },
  label: {
    fontSize: 14,
    fontWeight: "700",
    color: palette.earth,
    textTransform: "uppercase",
    letterSpacing: 1,
  },
  quote: {
    fontSize: 18,
    lineHeight: 27,
    color: palette.ink,
    fontWeight: "600",
  },
});
