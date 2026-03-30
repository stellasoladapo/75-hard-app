import 'package:flutter/material.dart';

import '../controllers/challenge_controller.dart';
import '../models/challenge_state.dart';
import '../widgets/fade_in_card.dart';
import '../widgets/nature_scaffold.dart';
import '../widgets/progress_strip.dart';
import '../widgets/section_card.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key, required this.controller});

  final ChallengeController controller;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return NatureScaffold(
      imageUrl:
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=1400&q=80',
      overlayColors: const <Color>[
        Color(0x44426E70),
        Color(0xBFE7F5ED),
        Color(0xF0F1F8E9),
      ],
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
        children: <Widget>[
          FadeInCard(
            child: _ProgressHero(controller: controller),
          ),
          const SizedBox(height: 18),
          if (controller.startDate == null)
            FadeInCard(
              delay: const Duration(milliseconds: 80),
              child: SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('No challenge in motion', style: theme.textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(
                      'Choose your start date on the home screen first. After that, this view will show every day across the full 75-day challenge.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            )
          else ...<Widget>[
            FadeInCard(
              delay: const Duration(milliseconds: 80),
              child: SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Challenge completion', style: theme.textTheme.titleLarge),
                    const SizedBox(height: 14),
                    ProgressStrip(
                      label: '75-day timeline',
                      value: controller.overallProgress,
                      completedLabel: 'Day ${controller.currentChallengeDay} of ${ChallengeController.challengeLength}',
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: _SummaryChip(
                            label: 'Perfect days',
                            value: controller.challengeDates
                                .where((DateTime date) {
                                  final DayEntry entry = controller.entryForDate(date);
                                  return controller.completedHabitCount(entry) ==
                                      ChallengeController.habits.length;
                                })
                                .length
                                .toString(),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _SummaryChip(
                            label: 'Start date',
                            value: MaterialLocalizations.of(context).formatMediumDate(controller.startDate!),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            FadeInCard(
              delay: const Duration(milliseconds: 160),
              child: SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Day-by-day streak', style: theme.textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(
                      'Each entry reflects the habits completed for that day.',
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 18),
                    for (int index = 0; index < controller.challengeDates.length; index++)
                      _DayProgressRow(
                        dayNumber: index + 1,
                        date: controller.challengeDates[index],
                        controller: controller,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ProgressHero extends StatelessWidget {
  const _ProgressHero({required this.controller});

  final ChallengeController controller;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: <Color>[
            Color(0xD6F1F8E9),
            Color(0xC4A5D6A7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x220E2414),
            blurRadius: 24,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'PROGRESS',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.secondary,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  controller.startDate == null ? 'Build the timeline' : 'Keep the streak honest',
                  style: theme.textTheme.headlineMedium,
                ),
                const SizedBox(height: 10),
                Text(
                  controller.startDate == null
                      ? 'The moment you start, the app turns into a 75-day ledger.'
                      : 'Every day stays visible, so the trend is impossible to fake.',
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 34,
            backgroundColor: Colors.white.withValues(alpha: 0.55),
            child: Text(
              controller.startDate == null ? '--' : '${controller.currentChallengeDay}',
              style: theme.textTheme.headlineSmall,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label.toUpperCase(),
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.primary.withValues(alpha: 0.68),
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(value, style: theme.textTheme.titleLarge),
        ],
      ),
    );
  }
}

class _DayProgressRow extends StatelessWidget {
  const _DayProgressRow({
    required this.dayNumber,
    required this.date,
    required this.controller,
  });

  final int dayNumber;
  final DateTime date;
  final ChallengeController controller;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DayEntry entry = controller.entryForDate(date);
    final double progress = controller.progressForEntry(entry);
    final int completed = controller.completedHabitCount(entry);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.48),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Day $dayNumber', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(
                  MaterialLocalizations.of(context).formatFullDate(date),
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 96,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  '$completed/${ChallengeController.habits.length}',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    minHeight: 8,
                    value: progress,
                    backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
