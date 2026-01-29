import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final ColorScheme cs;
  final String title;
  final String description;
  final IconData icon;
  final List<Widget>? actions;
  const EmptyState({
    super.key,
    required this.cs,
    required this.title,
    required this.description,
    required this.icon,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 100, color: cs.outline.withOpacity(0.4)),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: cs.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: cs.onSurface.withOpacity(0.7),
              ),
            ),
            SizedBox(height: 20),
            ...actions ?? [],
          ],
        ),
      ),
    );
  }
}
