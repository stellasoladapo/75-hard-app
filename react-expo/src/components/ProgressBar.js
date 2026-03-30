import React from "react";
import { StyleSheet, Text, View } from "react-native";
import { palette } from "../theme/palette";

export default function ProgressBar({ label, progress }) {
  const safeProgress = Math.max(0, Math.min(progress, 1));
  return (
    <View style={styles.container}>
      <View style={styles.row}>
        <Text style={styles.label}>{label}</Text>
        <Text style={styles.value}>{Math.round(safeProgress * 100)}%</Text>
      </View>
      <View style={styles.track}>
        <View style={[styles.fill, { width: `${safeProgress * 100}%` }]} />
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    gap: 8,
  },
  row: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  label: {
    color: palette.ink,
    fontSize: 14,
    fontWeight: "700",
  },
  value: {
    color: palette.forest,
    fontSize: 14,
    fontWeight: "800",
  },
  track: {
    height: 12,
    borderRadius: 999,
    backgroundColor: "rgba(49,92,61,0.10)",
    overflow: "hidden",
  },
  fill: {
    height: "100%",
    borderRadius: 999,
    backgroundColor: palette.moss,
  },
});
