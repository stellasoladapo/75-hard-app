import React from "react";
import { ImageBackground, StyleSheet, View } from "react-native";
import { LinearGradient } from "expo-linear-gradient";

export default function ScreenBackground({ image, children }) {
  return (
    <ImageBackground source={{ uri: image }} style={styles.background}>
      <LinearGradient colors={["rgba(18,30,20,0.12)", "rgba(238,244,234,0.95)"]} style={styles.overlay}>
        <View style={styles.content}>{children}</View>
      </LinearGradient>
    </ImageBackground>
  );
}

const styles = StyleSheet.create({
  background: {
    flex: 1,
  },
  overlay: {
    flex: 1,
  },
  content: {
    flex: 1,
  },
});
