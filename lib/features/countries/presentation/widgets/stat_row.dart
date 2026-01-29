import 'package:flutter/material.dart';

class StatRow extends StatelessWidget {
  final String label;
  final String value;

  const StatRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
          ),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: cs.primary),
          ),
        ],
      ),
    );
  }
}
