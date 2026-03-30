import fs from "node:fs";
import path from "node:path";

const root = process.cwd();
const modelPath = path.join(root, "model", "challenge-definition.json");
const reactOutputPath = path.join(root, "react-expo", "src", "generated", "challengeModel.js");
const flutterOutputPath = path.join(root, "flutter", "lib", "generated", "challenge_definition.dart");

const definition = JSON.parse(fs.readFileSync(modelPath, "utf8"));

function ensureDir(filePath) {
  fs.mkdirSync(path.dirname(filePath), { recursive: true });
}

function jsValue(value, indent = 0) {
  const space = "  ".repeat(indent);
  const next = "  ".repeat(indent + 1);

  if (Array.isArray(value)) {
    if (value.length === 0) {
      return "[]";
    }
    return `[\n${value.map((item) => `${next}${jsValue(item, indent + 1)}`).join(",\n")}\n${space}]`;
  }

  if (value && typeof value === "object") {
    const entries = Object.entries(value);
    if (entries.length === 0) {
      return "{}";
    }
    return `{\n${entries
      .map(([key, item]) => `${next}${JSON.stringify(key)}: ${jsValue(item, indent + 1)}`)
      .join(",\n")}\n${space}}`;
  }

  return JSON.stringify(value);
}

function dartString(value) {
  return `'${String(value).replaceAll("\\", "\\\\").replaceAll("'", "\\'")}'`;
}

function dartBool(value) {
  return value ? "true" : "false";
}

function generateReact() {
  const content = `// Generated from /model/challenge-definition.json. Do not edit by hand.
export const challengeDefinition = ${jsValue(definition)};

export const APP_NAME = challengeDefinition.app.name;
export const CHALLENGE_LENGTH = challengeDefinition.challenge.length;
export const AFFIRMATION_STRATEGY = challengeDefinition.challenge.affirmationStrategy;
export const STORAGE_VERSION = challengeDefinition.persistence.storageVersion;
export const ENTRY_KEY_FORMAT = challengeDefinition.persistence.entryKeyFormat;
export const FEATURE_FLAGS = challengeDefinition.featureFlags;
export const SCREEN_TITLES = challengeDefinition.screens;
export const HABITS = challengeDefinition.habits;
export const HABIT_KEYS = HABITS.map((habit) => habit.key);
export const DAILY_AFFIRMATIONS = challengeDefinition.affirmations;
`;

  ensureDir(reactOutputPath);
  fs.writeFileSync(reactOutputPath, content);
}

function generateFlutter() {
  const habits = definition.habits
    .map(
      (habit) =>
        `  HabitDefinition(\n    key: ${dartString(habit.key)},\n    title: ${dartString(
          habit.title
        )},\n    subtitle: ${dartString(habit.subtitle)},\n  )`
    )
    .join(",\n");

  const featureFlags = Object.entries(definition.featureFlags)
    .map(([key, value]) => `  ${dartString(key)}: ${dartBool(value)}`)
    .join(",\n");

  const screenTitles = Object.entries(definition.screens)
    .map(([key, value]) => `  ${dartString(key)}: ${dartString(value.title)}`)
    .join(",\n");

  const affirmations = definition.affirmations.map((item) => `  ${dartString(item)}`).join(",\n");
  const habitKeys = definition.habits.map((habit) => `  ${dartString(habit.key)}`).join(",\n");

  const content = `// Generated from /model/challenge-definition.json. Do not edit by hand.
class HabitDefinition {
  const HabitDefinition({
    required this.key,
    required this.title,
    required this.subtitle,
  });

  final String key;
  final String title;
  final String subtitle;
}

const String appName = ${dartString(definition.app.name)};
const int challengeLength = ${definition.challenge.length};
const String affirmationStrategy = ${dartString(definition.challenge.affirmationStrategy)};
const int storageVersion = ${definition.persistence.storageVersion};
const String entryKeyFormat = ${dartString(definition.persistence.entryKeyFormat)};

const Map<String, bool> featureFlags = <String, bool>{
${featureFlags}
};

const Map<String, String> screenTitles = <String, String>{
${screenTitles}
};

const List<HabitDefinition> habits = <HabitDefinition>[
${habits}
];

const List<String> habitKeys = <String>[
${habitKeys}
];

const List<String> dailyAffirmations = <String>[
${affirmations}
];
`;

  ensureDir(flutterOutputPath);
  fs.writeFileSync(flutterOutputPath, content);
}

generateReact();
generateFlutter();

console.log(`Generated:\n- ${reactOutputPath}\n- ${flutterOutputPath}`);
