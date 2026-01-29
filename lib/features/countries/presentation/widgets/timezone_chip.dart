import 'package:flutter/material.dart';

class TimezoneChip extends StatelessWidget {
  final String label;
  final bool isDark;

  const TimezoneChip({super.key, required this.label, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outline.withOpacity(0.4)),
        color: isDark ? cs.surface : cs.background,
      ),
      child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
