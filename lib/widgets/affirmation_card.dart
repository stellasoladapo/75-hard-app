import 'package:flutter/material.dart';

import 'section_card.dart';

class AffirmationCard extends StatelessWidget {
  const AffirmationCard({super.key, required this.quote});

  final String quote;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.wb_sunny_outlined, color: theme.colorScheme.secondary),
              const SizedBox(width: 8),
              Text(
                'DAILY AFFIRMATION',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.secondary,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            quote,
            style: theme.textTheme.titleLarge?.copyWith(height: 1.35),
          ),
        ],
      ),
    );
  }
}
