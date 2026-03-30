import 'package:flutter/material.dart';

import 'controllers/challenge_controller.dart';
import 'screens/app_shell.dart';
import 'services/challenge_storage.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final controller = ChallengeController(
    storage: ChallengeStorage(),
  );
  await controller.load();

  runApp(SeventyFiveHardApp(controller: controller));
}

class SeventyFiveHardApp extends StatelessWidget {
  const SeventyFiveHardApp({super.key, required this.controller});

  final ChallengeController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '75 Hard Tracker',
          theme: buildAppTheme(),
          home: AppShell(controller: controller),
        );
      },
    );
  }
}
