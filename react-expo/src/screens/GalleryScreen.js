import React from "react";
import {
  Alert,
  Image,
  Pressable,
  ScrollView,
  StyleSheet,
  Text,
  View,
} from "react-native";
import { SafeAreaView } from "react-native-safe-area-context";
import { Ionicons } from "@expo/vector-icons";
import * as ImagePicker from "expo-image-picker";
import { NATURE_BACKGROUNDS } from "../constants/challenge";
import { useChallenge } from "../context/ChallengeContext";
import { formatLongDate, getDateKey, parseDateKey } from "../utils/date";
import ScreenBackground from "../components/ScreenBackground";
import HeroHeader from "../components/HeroHeader";
import GlassCard from "../components/GlassCard";
import { palette } from "../theme/palette";

async function requestPermission() {
  const permission = await ImagePicker.requestMediaLibraryPermissionsAsync();
  return permission.granted;
}

export default function GalleryScreen() {
  const { setPhoto, photoEntries } = useChallenge();

  const handleAddPhoto = async () => {
    const granted = await requestPermission();
    if (!granted) {
      Alert.alert("Permission needed", "Photo library access is required to attach progress photos.");
      return;
    }

    const result = await ImagePicker.launchImageLibraryAsync({
      mediaTypes: ImagePicker.MediaTypeOptions.Images,
      quality: 0.8,
      allowsEditing: true,
      aspect: [4, 5],
    });

    if (!result.canceled && result.assets?.[0]?.uri) {
      setPhoto(getDateKey(), result.assets[0].uri);
    }
  };

  return (
    <ScreenBackground image={NATURE_BACKGROUNDS.gallery}>
      <SafeAreaView style={styles.safeArea}>
        <ScrollView contentContainerStyle={styles.content} showsVerticalScrollIndicator={false}>
          <HeroHeader
            eyebrow="Photo Gallery"
            title="Capture the visual proof"
            subtitle="Attach today’s progress photo and review the timeline of your physical changes."
            rightContent={
              <Pressable style={styles.addButton} onPress={handleAddPhoto}>
                <Ionicons name="add" size={18} color="#FFF" />
                <Text style={styles.addButtonText}>Add photo</Text>
              </Pressable>
            }
          />

          {photoEntries.length ? (
            <View style={styles.grid}>
              {photoEntries.map((entry) => (
                <GlassCard key={entry.dateKey} style={styles.photoCard}>
                  <Image source={{ uri: entry.photoUri }} style={styles.photo} />
                  <View style={styles.photoMeta}>
                    <Text style={styles.photoDate}>{formatLongDate(parseDateKey(entry.dateKey))}</Text>
                    <Text style={styles.photoCaption}>Saved to today’s checklist entry.</Text>
                  </View>
                </GlassCard>
              ))}
            </View>
          ) : (
            <GlassCard>
              <Text style={styles.emptyTitle}>No progress photos yet.</Text>
              <Text style={styles.emptyBody}>
                Add your first image to begin the gallery. The selected photo will also mark the “progress picture” habit complete for today.
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
  addButton: {
    flexDirection: "row",
    alignItems: "center",
    gap: 8,
    backgroundColor: palette.forest,
    paddingVertical: 12,
    paddingHorizontal: 16,
    borderRadius: 999,
  },
  addButtonText: {
    color: "#FFF",
    fontSize: 13,
    fontWeight: "800",
  },
  grid: {
    gap: 16,
  },
  photoCard: {
    overflow: "hidden",
    padding: 0,
  },
  photo: {
    width: "100%",
    height: 320,
    backgroundColor: "rgba(49,92,61,0.10)",
  },
  photoMeta: {
    padding: 16,
  },
  photoDate: {
    color: palette.ink,
    fontSize: 16,
    fontWeight: "800",
    marginBottom: 6,
  },
  photoCaption: {
    color: palette.stone,
    fontSize: 14,
    lineHeight: 20,
  },
  emptyTitle: {
    fontSize: 20,
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
