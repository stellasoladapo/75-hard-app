import 'package:flutter/foundation.dart';

import '../data/affirmations.dart';
import '../models/challenge_state.dart';
import '../services/challenge_storage.dart';

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

class ChallengeController extends ChangeNotifier {
  ChallengeController({required ChallengeStorage storage}) : _storage = storage;

  static const int challengeLength = 75;

  static const List<HabitDefinition> habits = <HabitDefinition>[
    HabitDefinition(
      key: 'water',
      title: 'Drink 1 gallon of water',
      subtitle: 'Hydrate steadily and finish the full gallon.',
    ),
    HabitDefinition(
      key: 'workouts',
      title: 'Complete 2 workouts',
      subtitle: 'Make sure one of the workouts happens outdoors.',
    ),
    HabitDefinition(
      key: 'reading',
      title: 'Read 10 pages',
      subtitle: 'Keep it nonfiction and distraction-free.',
    ),
    HabitDefinition(
      key: 'photo',
      title: 'Take a progress picture',
      subtitle: 'Capture one honest photo every day.',
    ),
    HabitDefinition(
      key: 'diet',
      title: 'Follow a clean diet',
      subtitle: 'Include vegetables, fruits, and no alcohol.',
    ),
  ];

  final ChallengeStorage _storage;
  ChallengeState _state = ChallengeState();

  ChallengeState get state => _state;
  DateTime? get startDate => _state.startDate;

  Future<void> load() async {
    _state = await _storage.load();
    notifyListeners();
  }

  String get todayKey => _dateKey(DateTime.now());

  DayEntry entryForDate(DateTime date) {
    return _entryByKey(_dateKey(date));
  }

  DayEntry entryForKey(String dateKey) {
    return _entryByKey(dateKey);
  }

  int get currentChallengeDay {
    final DateTime? date = startDate;
    if (date == null) {
      return 0;
    }

    final int days = DateTime.now().difference(_stripTime(date)).inDays + 1;
    if (days < 1) {
      return 0;
    }
    if (days > challengeLength) {
      return challengeLength;
    }
    return days;
  }

  double get overallProgress {
    if (startDate == null) {
      return 0;
    }
    return currentChallengeDay / challengeLength;
  }

  double progressForEntry(DayEntry entry) {
    final int done = entry.checklist.values.where((bool value) => value).length;
    return done / habits.length;
  }

  int completedHabitCount(DayEntry entry) {
    return entry.checklist.values.where((bool value) => value).length;
  }

  String affirmationForToday() {
    final String key = todayKey;
    final int seed = key.codeUnits.fold<int>(0, (int total, int unit) => total + unit);
    return dailyAffirmations[seed % dailyAffirmations.length];
  }

  List<DayEntry> get photoEntries {
    final List<DayEntry> entries = _state.entries.values
        .where((DayEntry entry) => entry.photoPath != null && entry.photoPath!.isNotEmpty)
        .toList()
      ..sort((DayEntry a, DayEntry b) => b.dateKey.compareTo(a.dateKey));
    return entries;
  }

  List<DateTime> get challengeDates {
    final DateTime base = _stripTime(startDate ?? DateTime.now());
    return List<DateTime>.generate(
      challengeLength,
      (int index) => base.add(Duration(days: index)),
    );
  }

  Future<void> setStartDate(DateTime date) async {
    _state = _state.copyWith(startDate: _stripTime(date));
    await _persist();
  }

  Future<void> toggleHabit(String dateKey, String habitKey) async {
    final DayEntry entry = _entryByKey(dateKey);
    final Map<String, bool> checklist = Map<String, bool>.from(entry.checklist);
    checklist[habitKey] = !(checklist[habitKey] ?? false);

    final DayEntry updated = entry.copyWith(checklist: checklist);
    _state = _state.copyWith(
      entries: <String, DayEntry>{
        ..._state.entries,
        dateKey: updated,
      },
    );
    await _persist();
  }

  Future<void> setPhotoForToday(String path) async {
    final DayEntry entry = _entryByKey(todayKey);
    final Map<String, bool> checklist = Map<String, bool>.from(entry.checklist)
      ..['photo'] = path.isNotEmpty;

    final DayEntry updated = entry.copyWith(
      checklist: checklist,
      photoPath: path,
    );

    _state = _state.copyWith(
      entries: <String, DayEntry>{
        ..._state.entries,
        todayKey: updated,
      },
    );
    await _persist();
  }

  Future<void> _persist() async {
    await _storage.save(_state);
    notifyListeners();
  }

  DayEntry _entryByKey(String dateKey) {
    return _state.entries[dateKey] ?? DayEntry(dateKey: dateKey);
  }

  String _dateKey(DateTime date) {
    final DateTime local = _stripTime(date);
    final String year = local.year.toString().padLeft(4, '0');
    final String month = local.month.toString().padLeft(2, '0');
    final String day = local.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  DateTime _stripTime(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
