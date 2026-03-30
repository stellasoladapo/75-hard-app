// Generated from /model/challenge-definition.json. Do not edit by hand.
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

const String appName = '75 Hard Tracker';
const int challengeLength = 75;
const String affirmationStrategy = 'daily-index';
const int storageVersion = 1;
const String entryKeyFormat = 'yyyy-mm-dd';

const Map<String, bool> featureFlags = <String, bool>{
  'dailyAffirmations': true,
  'photoGallery': true,
  'progressTimeline': true
};

const Map<String, String> screenTitles = <String, String>{
  'home': 'Home',
  'progress': 'Progress',
  'gallery': 'Photos'
};

const List<HabitDefinition> habits = <HabitDefinition>[
  HabitDefinition(
    key: 'water',
    title: 'Drink 1 gallon of water',
    subtitle: 'Hydrate steadily through the day.',
  ),
  HabitDefinition(
    key: 'workouts',
    title: 'Complete 2 workouts',
    subtitle: 'One workout must happen outdoors.',
  ),
  HabitDefinition(
    key: 'reading',
    title: 'Read 10 pages',
    subtitle: 'Keep it nonfiction and distraction-free.',
  ),
  HabitDefinition(
    key: 'photo',
    title: 'Take a progress picture',
    subtitle: 'Capture one honest snapshot each day.',
  ),
  HabitDefinition(
    key: 'diet',
    title: 'Follow a clean diet',
    subtitle: 'Vegetables, fruits, no alcohol.',
  )
];

const List<String> habitKeys = <String>[
  'water',
  'workouts',
  'reading',
  'photo',
  'diet'
];

const List<String> dailyAffirmations = <String>[
  'Discipline grows every time you keep a promise to yourself.',
  'Small daily wins become a different life.',
  'The hard path becomes lighter when you stop negotiating with it.',
  'Momentum is built by finishing the next honest task.',
  'Strength is quiet repetition done on ordinary days.',
  'Your future self is shaped by today’s unglamorous choices.',
  'Consistency is proof that your goals matter more than your mood.',
  'Progress looks ordinary while you are living it.',
  'Commitment is doing the work before the motivation arrives.',
  'One disciplined day can reset an undisciplined week.',
  'The standard becomes easier when it becomes non-negotiable.',
  'You do not need perfect conditions to build a stronger self.'
];
