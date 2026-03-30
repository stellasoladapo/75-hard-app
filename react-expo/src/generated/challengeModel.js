// Generated from /model/challenge-definition.json. Do not edit by hand.
export const challengeDefinition = {
  "app": {
    "name": "75 Hard Tracker"
  },
  "challenge": {
    "length": 75,
    "affirmationStrategy": "daily-index"
  },
  "persistence": {
    "storageVersion": 1,
    "entryKeyFormat": "yyyy-mm-dd"
  },
  "featureFlags": {
    "dailyAffirmations": true,
    "photoGallery": true,
    "progressTimeline": true
  },
  "screens": {
    "home": {
      "title": "Home"
    },
    "progress": {
      "title": "Progress"
    },
    "gallery": {
      "title": "Photos"
    }
  },
  "habits": [
    {
      "key": "water",
      "title": "Drink 1 gallon of water",
      "subtitle": "Hydrate steadily through the day."
    },
    {
      "key": "workouts",
      "title": "Complete 2 workouts",
      "subtitle": "One workout must happen outdoors."
    },
    {
      "key": "reading",
      "title": "Read 10 pages",
      "subtitle": "Keep it nonfiction and distraction-free."
    },
    {
      "key": "photo",
      "title": "Take a progress picture",
      "subtitle": "Capture one honest snapshot each day."
    },
    {
      "key": "diet",
      "title": "Follow a clean diet",
      "subtitle": "Vegetables, fruits, no alcohol."
    }
  ],
  "affirmations": [
    "Discipline grows every time you keep a promise to yourself.",
    "Small daily wins become a different life.",
    "The hard path becomes lighter when you stop negotiating with it.",
    "Momentum is built by finishing the next honest task.",
    "Strength is quiet repetition done on ordinary days.",
    "Your future self is shaped by today’s unglamorous choices.",
    "Consistency is proof that your goals matter more than your mood.",
    "Progress looks ordinary while you are living it.",
    "Commitment is doing the work before the motivation arrives.",
    "One disciplined day can reset an undisciplined week.",
    "The standard becomes easier when it becomes non-negotiable.",
    "You do not need perfect conditions to build a stronger self."
  ]
};

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
