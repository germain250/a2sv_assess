import 'package:discover/core/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Countries"),
        centerTitle: true,
        actions: [
          Switch(
            value: isDark,
            onChanged: (_) {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
        ],
      ),
      body: const Center(child: Text("Countries goes here")),
    );
  }
}
