import 'package:flutter/material.dart';

class ChecklistItemTile extends StatelessWidget {
  const ChecklistItemTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.checked,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final bool checked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: checked
              ? theme.colorScheme.tertiary.withValues(alpha: 0.24)
              : const Color(0xFFF9FCF5).withValues(alpha: 0.58),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: checked
                ? theme.colorScheme.primary.withValues(alpha: 0.24)
                : theme.colorScheme.primary.withValues(alpha: 0.1),
          ),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x0F1B3B1A),
              blurRadius: 16,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: checked ? theme.colorScheme.primary : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.colorScheme.primary,
                  width: 2,
                ),
              ),
              child: checked
                  ? const Icon(Icons.check, size: 18, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle, style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
