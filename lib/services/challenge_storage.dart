import 'package:shared_preferences/shared_preferences.dart';

import '../models/challenge_state.dart';

class ChallengeStorage {
  static const String _storageKey = 'seventy_five_hard_tracker_state';

  Future<ChallengeState> load() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? rawState = preferences.getString(_storageKey);

    if (rawState == null || rawState.isEmpty) {
      return ChallengeState();
    }

    try {
      return ChallengeState.fromJson(rawState);
    } catch (_) {
      return ChallengeState();
    }
  }

  Future<void> save(ChallengeState state) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(_storageKey, state.toJson());
  }
}
