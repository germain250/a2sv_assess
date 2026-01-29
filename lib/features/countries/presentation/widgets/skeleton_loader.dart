import 'package:flutter/material.dart';

class CountrySkeleton extends StatelessWidget {
  const CountrySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 88,
        decoration: BoxDecoration(
          color: cs.surfaceVariant.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            Container(
              width: 56,
              height: 40,
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _line(cs, width: double.infinity),
                  const SizedBox(height: 8),
                  _line(cs, width: 120),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _line(ColorScheme cs, {double? width}) {
    return Container(
      width: width,
      height: 12,
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
