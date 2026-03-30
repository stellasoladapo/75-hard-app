import React from "react";
import { StyleSheet, View } from "react-native";
import { palette } from "../theme/palette";

export default function GlassCard({ children, style }) {
  return <View style={[styles.card, style]}>{children}</View>;
}

const styles = StyleSheet.create({
  card: {
    backgroundColor: palette.card,
    borderRadius: 24,
    borderWidth: 1,
    borderColor: "rgba(255,255,255,0.35)",
    padding: 18,
    shadowColor: "#203124",
    shadowOpacity: 0.12,
    shadowRadius: 16,
    shadowOffset: { width: 0, height: 10 },
    elevation: 6,
  },
});
