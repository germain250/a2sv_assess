import 'dart:async';

import 'package:flutter/material.dart';

class CountrySearchBar extends StatefulWidget {
  final ValueChanged<String> onSearchChanged;
  final String? initialQuery;
  final String hintText;
  final Duration debounceDuration;
  final double? elevation;
  final Widget? leading;

  const CountrySearchBar({
    super.key,
    required this.onSearchChanged,
    this.initialQuery,
    this.hintText = 'Search for a country',
    this.debounceDuration = const Duration(milliseconds: 350),
    this.elevation,
    this.leading,
  });

  @override
  State<CountrySearchBar> createState() => _CountrySearchBarState();
}

class _CountrySearchBarState extends State<CountrySearchBar> {
  late final TextEditingController _controller;
  Timer? _debounceTimer;
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);
    _controller.addListener(_updateClearButtonVisibility);
    _controller.addListener(_debounceSearch);
  }

  @override
  void dispose() {
    _controller.removeListener(_updateClearButtonVisibility);
    _controller.removeListener(_debounceSearch);
    _controller.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _updateClearButtonVisibility() {
    final shouldShow = _controller.text.isNotEmpty;
    if (shouldShow != _showClearButton) {
      setState(() => _showClearButton = shouldShow);
    }
  }

  void _debounceSearch() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(widget.debounceDuration, () {
      final query = _controller.text.trim();
      widget.onSearchChanged(query);
    });
  }

  void _clearSearch() {
    _controller.clear();
    widget.onSearchChanged('');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Material(
        elevation: widget.elevation ?? 0.0,
        borderRadius: BorderRadius.circular(12.0),
        color: colorScheme.surfaceContainerHighest,
        shadowColor: Theme.of(context).cardColor,
        child: TextField(
          controller: _controller,
          textInputAction: TextInputAction.search,
          autofocus: false,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            fillColor: Theme.of(context).cardColor,
            filled: true,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            prefixIcon:
                widget.leading ??
                Icon(Icons.search_rounded, color: colorScheme.primary),
            suffixIcon: _showClearButton
                ? IconButton(
                    icon: Icon(
                      Icons.clear_rounded,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    tooltip: 'Clear',
                    onPressed: _clearSearch,
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 20.0,
            ),
            isDense: true,
          ),
          onSubmitted: (value) {
            _debounceTimer?.cancel();
            widget.onSearchChanged(value.trim());
          },
        ),
      ),
    );
  }
}
