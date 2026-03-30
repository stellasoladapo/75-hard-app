import "react-native-gesture-handler";
import React from "react";
import { NavigationContainer, DefaultTheme } from "@react-navigation/native";
import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import { Ionicons } from "@expo/vector-icons";
import { StatusBar } from "expo-status-bar";
import HomeScreen from "./src/screens/HomeScreen";
import ProgressScreen from "./src/screens/ProgressScreen";
import GalleryScreen from "./src/screens/GalleryScreen";
import { ChallengeProvider } from "./src/context/ChallengeContext";
import { palette } from "./src/theme/palette";

const Tab = createBottomTabNavigator();

const navTheme = {
  ...DefaultTheme,
  colors: {
    ...DefaultTheme.colors,
    background: palette.mist,
    card: "#F6F2EA",
    primary: palette.forest,
    text: palette.ink,
    border: "transparent",
  },
};

const tabIcons = {
  Home: "leaf-outline",
  Progress: "analytics-outline",
  Gallery: "images-outline",
};

export default function App() {
  return (
    <ChallengeProvider>
      <NavigationContainer theme={navTheme}>
        <StatusBar style="dark" />
        <Tab.Navigator
          screenOptions={({ route }) => ({
            headerShown: false,
            tabBarActiveTintColor: palette.forest,
            tabBarInactiveTintColor: palette.stone,
            tabBarStyle: {
              position: "absolute",
              left: 18,
              right: 18,
              bottom: 18,
              height: 72,
              borderRadius: 24,
              backgroundColor: "rgba(248, 244, 235, 0.95)",
              borderTopWidth: 0,
              paddingTop: 10,
              paddingBottom: 10,
              shadowColor: "#1C2E1F",
              shadowOpacity: 0.14,
              shadowRadius: 14,
              shadowOffset: { width: 0, height: 8 },
              elevation: 10,
            },
            tabBarLabelStyle: {
              fontSize: 12,
              fontWeight: "700",
            },
            tabBarIcon: ({ color, size }) => (
              <Ionicons name={tabIcons[route.name]} size={size} color={color} />
            ),
          })}
        >
          <Tab.Screen name="Home" component={HomeScreen} />
          <Tab.Screen name="Progress" component={ProgressScreen} />
          <Tab.Screen name="Gallery" component={GalleryScreen} />
        </Tab.Navigator>
      </NavigationContainer>
    </ChallengeProvider>
  );
}
