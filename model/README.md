# Shared Model

This directory is the shared source of truth for challenge-level product data used by both app codebases.

Files:

- `challenge-definition.json`: shared schema for habits, challenge rules, affirmations, screen labels, flags, and persistence metadata.
- `generate.mjs`: simple generator that emits platform-specific constants into React and Flutter.

Run the generator from the workspace root:

```bash
node model/generate.mjs
```

Generated outputs:

- `react-expo/src/generated/challengeModel.js`
- `flutter/lib/generated/challenge_definition.dart`

Rule:

- Business definitions live here.
- Rendering and UI composition stay native in each platform codebase.
