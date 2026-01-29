import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const SearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Search countries",
          prefixIcon: Icon(Icons.search),
          filled: true,
          fillColor: Theme.of(context).cardColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
