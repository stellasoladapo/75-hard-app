import React from "react";
import { StyleSheet, Text, View } from "react-native";
import { LinearGradient } from "expo-linear-gradient";
import { palette } from "../theme/palette";

export default function HeroHeader({ eyebrow, title, subtitle, rightContent }) {
  return (
    <LinearGradient colors={["rgba(245,232,212,0.92)", "rgba(238,244,234,0.86)"]} style={styles.wrap}>
      <View style={styles.left}>
        <Text style={styles.eyebrow}>{eyebrow}</Text>
        <Text style={styles.title}>{title}</Text>
        {subtitle ? <Text style={styles.subtitle}>{subtitle}</Text> : null}
      </View>
      {rightContent ? <View style={styles.right}>{rightContent}</View> : null}
    </LinearGradient>
  );
}

const styles = StyleSheet.create({
  wrap: {
    borderRadius: 28,
    padding: 22,
    marginBottom: 18,
    shadowColor: "#203124",
    shadowOpacity: 0.14,
    shadowRadius: 18,
    shadowOffset: { width: 0, height: 10 },
    elevation: 8,
    flexDirection: "row",
    justifyContent: "space-between",
    gap: 16,
  },
  left: {
    flex: 1,
  },
  right: {
    justifyContent: "center",
    alignItems: "center",
  },
  eyebrow: {
    fontSize: 12,
    fontWeight: "800",
    color: palette.earth,
    textTransform: "uppercase",
    letterSpacing: 1.2,
    marginBottom: 8,
  },
  title: {
    fontSize: 28,
    lineHeight: 34,
    fontWeight: "800",
    color: palette.ink,
  },
  subtitle: {
    marginTop: 8,
    color: palette.stone,
    fontSize: 15,
    lineHeight: 22,
  },
});
