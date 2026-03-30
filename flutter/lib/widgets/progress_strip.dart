import 'package:flutter/material.dart';

class ProgressStrip extends StatelessWidget {
  const ProgressStrip({
    super.key,
    required this.label,
    required this.value,
    required this.completedLabel,
  });

  final String label;
  final double value;
  final String completedLabel;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double safeValue = value.clamp(0, 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(label, style: theme.textTheme.labelLarge),
            ),
            Text(
              '${(safeValue * 100).round()}%',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            minHeight: 12,
            value: safeValue,
            backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.12),
            valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
          ),
        ),
        const SizedBox(height: 8),
        Text(completedLabel, style: theme.textTheme.bodySmall),
      ],
    );
  }
}
