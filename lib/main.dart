import 'package:discover/core/network/api_client.dart';
import 'package:discover/core/theme/app_theme.dart';
import 'package:discover/core/theme/theme_cubit.dart';
import 'package:discover/features/countries/bloc/country_bloc.dart';
import 'package:discover/features/countries/bloc/country_event.dart';
import 'package:discover/features/countries/data/datasources/country_remote_datasource.dart';
import 'package:discover/features/countries/data/datasources/favorite_local_datasource.dart';
import 'package:discover/features/countries/data/repositories/country_repository_impl.dart';
import 'package:discover/features/countries/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const CountriesApp());
}

class CountriesApp extends StatelessWidget {
  const CountriesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiClient = ApiClient(http.Client());
    final remoteDatasource = CountryRemoteDatasourceImpl(apiClient);
    final repository = CountryRepositoryImpl(remoteDatasource);
    final favorites = FavoriteLocalDatasourceImpl();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(
          create: (_) => CountryBloc(repository, favorites)
            ..add(LoadFavorites())
            ..add(FetchCountries())
            ..add(ToggleFavorite('')),
        ),
      ],
      child: BlocBuilder<ThemeCubit, bool>(
        builder: (context, isDarkMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
