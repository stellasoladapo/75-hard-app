# 75 Hard App

Monorepo for the 75 Hard Tracker project.

## Structure

```text
75-hard/
  flutter/      Flutter app (primary)
  react-expo/   React Native + Expo app
  model/        Shared product model and code generator
```

## Projects

### Flutter

Primary app codebase.

Path: [flutter](/Users/yoda/code/projects/75-hard/flutter)

Run:

```bash
cd flutter
flutter pub get
flutter run
```

Build examples:

```bash
flutter build apk --release
flutter build ios --release
flutter build web --release
```

### React Expo

Secondary implementation for shared model and cross-platform experiments.

Path: [react-expo](/Users/yoda/code/projects/75-hard/react-expo)

Run:

```bash
cd react-expo
npm install
npx expo start
```

## Shared Model

Shared product definitions live in:

- [model/challenge-definition.json](/Users/yoda/code/projects/75-hard/model/challenge-definition.json)

This file is the source of truth for:

- challenge length
- habits
- affirmations
- feature flags
- screen labels
- persistence metadata

Generate platform-specific outputs from the repo root:

```bash
node model/generate.mjs
```

Generated files:

- [react-expo/src/generated/challengeModel.js](/Users/yoda/code/projects/75-hard/react-expo/src/generated/challengeModel.js)
- [flutter/lib/generated/challenge_definition.dart](/Users/yoda/code/projects/75-hard/flutter/lib/generated/challenge_definition.dart)

## Workflow

1. Edit the shared definition in `model/challenge-definition.json`
2. Run `node model/generate.mjs`
3. Continue platform-specific UI work in `flutter/` or `react-expo/`

## Git

This repository is intended to track the entire monorepo from the root, not the nested app folders as separate repositories.
