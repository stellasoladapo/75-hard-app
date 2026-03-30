import 'dart:convert';

import '../generated/challenge_definition.dart';

Map<String, bool> buildHabitChecklist() {
  return <String, bool>{
    for (final String key in habitKeys) key: false,
  };
}

class DayEntry {
  DayEntry({
    required this.dateKey,
    Map<String, bool>? checklist,
    this.photoPath,
    DateTime? updatedAt,
  })  : checklist = checklist ?? buildHabitChecklist(),
        updatedAt = updatedAt ?? DateTime.now();

  final String dateKey;
  final Map<String, bool> checklist;
  final String? photoPath;
  final DateTime updatedAt;

  DayEntry copyWith({
    Map<String, bool>? checklist,
    String? photoPath,
    bool clearPhoto = false,
    DateTime? updatedAt,
  }) {
    return DayEntry(
      dateKey: dateKey,
      checklist: checklist ?? Map<String, bool>.from(this.checklist),
      photoPath: clearPhoto ? null : (photoPath ?? this.photoPath),
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateKey': dateKey,
      'checklist': checklist,
      'photoPath': photoPath,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory DayEntry.fromMap(Map<String, dynamic> map) {
    final dynamic rawChecklist = map['checklist'];
    final Map<String, bool> parsedChecklist = buildHabitChecklist();

    if (rawChecklist is Map) {
      for (final MapEntry<dynamic, dynamic> entry in rawChecklist.entries) {
        parsedChecklist[entry.key.toString()] = entry.value == true;
      }
    }

    return DayEntry(
      dateKey: map['dateKey'] as String,
      checklist: parsedChecklist,
      photoPath: map['photoPath'] as String?,
      updatedAt: DateTime.tryParse(map['updatedAt'] as String? ?? '') ?? DateTime.now(),
    );
  }
}

class ChallengeState {
  ChallengeState({
    this.startDate,
    Map<String, DayEntry>? entries,
  }) : entries = entries ?? <String, DayEntry>{};

  final DateTime? startDate;
  final Map<String, DayEntry> entries;

  ChallengeState copyWith({
    DateTime? startDate,
    bool clearStartDate = false,
    Map<String, DayEntry>? entries,
  }) {
    return ChallengeState(
      startDate: clearStartDate ? null : (startDate ?? this.startDate),
      entries: entries ?? Map<String, DayEntry>.from(this.entries),
    );
  }

  String toJson() {
    return jsonEncode(
      <String, dynamic>{
        'startDate': startDate?.toIso8601String(),
        'entries': entries.map(
          (String key, DayEntry value) => MapEntry<String, dynamic>(key, value.toMap()),
        ),
      },
    );
  }

  factory ChallengeState.fromJson(String json) {
    final Map<String, dynamic> map = jsonDecode(json) as Map<String, dynamic>;
    final Map<String, dynamic> rawEntries =
        (map['entries'] as Map<String, dynamic>?) ?? <String, dynamic>{};

    return ChallengeState(
      startDate: DateTime.tryParse(map['startDate'] as String? ?? ''),
      entries: rawEntries.map(
        (String key, dynamic value) => MapEntry<String, DayEntry>(
          key,
          DayEntry.fromMap(Map<String, dynamic>.from(value as Map)),
        ),
      ),
    );
  }
}
