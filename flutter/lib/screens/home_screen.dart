import 'package:flutter/material.dart';

import '../controllers/challenge_controller.dart';
import '../models/challenge_state.dart';
import '../widgets/affirmation_card.dart';
import '../widgets/checklist_item_tile.dart';
import '../widgets/fade_in_card.dart';
import '../widgets/nature_scaffold.dart';
import '../widgets/progress_strip.dart';
import '../widgets/section_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.controller});

  final ChallengeController controller;

  Future<void> _pickStartDate(BuildContext context) async {
    final DateTime initialDate = controller.startDate ?? DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 3650)),
      lastDate: DateTime.now(),
      initialDate: initialDate,
      helpText: 'Select your 75 Hard start date',
    );

    if (picked != null) {
      await controller.setStartDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DayEntry todayEntry = controller.entryForKey(controller.todayKey);
    final double progress = controller.progressForEntry(todayEntry);
    final int completed = controller.completedHabitCount(todayEntry);
    final int dayNumber = controller.currentChallengeDay;

    return NatureScaffold(
      imageUrl:
          'https://images.unsplash.com/photo-1502082553048-f009c37129b9?auto=format&fit=crop&w=1400&q=80',
      overlayColors: const <Color>[
        Color(0x55375C38),
        Color(0xBFF1F8E9),
        Color(0xF2F1F8E9),
      ],
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
        children: <Widget>[
          FadeInCard(
            child: _HeroCard(
              title: controller.startDate == null ? 'Start your 75 days' : 'Day ${dayNumber == 0 ? 1 : dayNumber}',
              subtitle: controller.startDate == null
                  ? 'Pick a start date and lock in the challenge.'
                  : 'Today is for stacking proof through simple, hard actions.',
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${(progress * 100).round()}%',
                    style: theme.textTheme.headlineSmall,
                  ),
                  Text(
                    'today',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary.withValues(alpha: 0.72),
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          FadeInCard(
            delay: const Duration(milliseconds: 80),
            child: SectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Challenge start date',
                          style: theme.textTheme.titleLarge,
                        ),
                      ),
                      FilledButton.tonalIcon(
                        onPressed: () => _pickStartDate(context),
                        icon: const Icon(Icons.calendar_month_outlined),
                        label: Text(
                          controller.startDate == null
                              ? 'Pick date'
                              : MaterialLocalizations.of(context).formatMediumDate(controller.startDate!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'The 75-day timeline starts from this date, and each daily entry stays saved locally on the device.',
                    style: theme.textTheme.bodyMedium,
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
                  Text('Today\'s checklist', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 6),
                  Text(
                    MaterialLocalizations.of(context).formatFullDate(DateTime.now()),
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  ProgressStrip(
                    label: 'Daily progress',
                    value: progress,
                    completedLabel: '$completed of ${ChallengeController.habits.length} habits done',
                  ),
                  const SizedBox(height: 18),
                  for (final HabitDefinition habit in ChallengeController.habits)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ChecklistItemTile(
                        title: habit.title,
                        subtitle: habit.subtitle,
                        checked: todayEntry.checklist[habit.key] ?? false,
                        onTap: () => controller.toggleHabit(controller.todayKey, habit.key),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          FadeInCard(
            delay: const Duration(milliseconds: 240),
            child: AffirmationCard(
              quote: controller.affirmationForToday(),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  final String title;
  final String subtitle;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: <Color>[
            Color(0xE6F1F8E9),
            Color(0xD6A5D6A7),
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
                  '75 HARD TRACKER',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.secondary,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(title, style: theme.textTheme.headlineMedium),
                const SizedBox(height: 10),
                Text(subtitle, style: theme.textTheme.bodyLarge),
              ],
            ),
          ),
          const SizedBox(width: 16),
          trailing,
        ],
      ),
    );
  }
}
