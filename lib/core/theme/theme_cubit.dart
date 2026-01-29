import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<bool> {
  static const String _themeKey = 'isDarkMode';

  ThemeCubit() : super(false) {
    _loadTheme();
  }
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIsDark = prefs.getBool(_themeKey) ?? false;
    emit(savedIsDark);
  }

  Future<void> toggleTheme() async {
    final newIsDark = !state;

    emit(newIsDark);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, newIsDark);
  }
}
