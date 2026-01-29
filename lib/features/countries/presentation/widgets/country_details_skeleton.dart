import 'package:flutter/material.dart';

class CountryDetailSkeleton extends StatelessWidget {
  const CountryDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Container(
          height: 260,
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _line(width: 180),
              const SizedBox(height: 24),

              _row(),
              _row(),
              _row(),
              _row(),

              const SizedBox(height: 40),
              _line(width: 120),
              const SizedBox(height: 16),

              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(
                  3,
                  (_) => Container(
                    width: 90,
                    height: 40,
                    decoration: BoxDecoration(
                      color: cs.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _line({double width = double.infinity}) {
    return Container(
      height: 18,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  Widget _row() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_line(width: 100), _line(width: 120)],
      ),
    );
  }
}
