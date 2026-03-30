import React from "react";
import { Pressable, StyleSheet, Text, View } from "react-native";
import { Ionicons } from "@expo/vector-icons";
import { palette } from "../theme/palette";

export default function ChecklistItem({ title, subtitle, checked, onPress }) {
  return (
    <Pressable onPress={onPress} style={[styles.row, checked && styles.rowChecked]}>
      <View style={[styles.checkbox, checked && styles.checkboxChecked]}>
        <Ionicons name="checkmark" size={18} color={checked ? "#FFF" : "transparent"} />
      </View>
      <View style={styles.textWrap}>
        <Text style={styles.title}>{title}</Text>
        <Text style={styles.subtitle}>{subtitle}</Text>
      </View>
    </Pressable>
  );
}

const styles = StyleSheet.create({
  row: {
    flexDirection: "row",
    alignItems: "center",
    gap: 14,
    paddingVertical: 14,
    paddingHorizontal: 12,
    borderRadius: 20,
    backgroundColor: "rgba(255,255,255,0.48)",
    marginBottom: 12,
    borderWidth: 1,
    borderColor: "rgba(49,92,61,0.08)",
  },
  rowChecked: {
    backgroundColor: "rgba(169,195,160,0.22)",
  },
  checkbox: {
    width: 28,
    height: 28,
    borderRadius: 14,
    borderWidth: 2,
    borderColor: palette.moss,
    alignItems: "center",
    justifyContent: "center",
    backgroundColor: "transparent",
  },
  checkboxChecked: {
    backgroundColor: palette.moss,
  },
  textWrap: {
    flex: 1,
  },
  title: {
    fontSize: 15,
    fontWeight: "700",
    color: palette.ink,
    marginBottom: 4,
  },
  subtitle: {
    fontSize: 13,
    color: palette.stone,
    lineHeight: 18,
  },
});
