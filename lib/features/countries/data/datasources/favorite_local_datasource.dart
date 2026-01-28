import 'package:discover/core/constants/app_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FavoriteLocalDatasource {
  Future<Set<String>> getFavoritesIds();
  Future<void> toggleFavorite(String cca2);
  Future<bool> isFavorite(String cca2);
}

class FavoriteLocalDatasourceImpl implements FavoriteLocalDatasource {
  @override
  Future<Set<String>> getFavoritesIds() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(AppKeys.favorites) ?? [];
    return list.toSet();
  }

  @override
  Future<bool> isFavorite(String cca2) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(AppKeys.favorites) ?? [];

    return favorites.contains(cca2);
  }

  @override
  Future<void> toggleFavorite(String cca2) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(AppKeys.favorites) ?? [];

    if (favorites.contains(cca2)) {
      favorites.remove(cca2);
    } else {
      favorites.add(cca2);
    }
    await prefs.setStringList(AppKeys.favorites, favorites);
  }
}
