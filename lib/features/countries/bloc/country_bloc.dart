import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/entities/country.dart';
import '../domain/repositories/country_repository.dart';
import '../data/datasources/favorite_local_datasource.dart';
import 'country_event.dart';
import 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final CountryRepository repository;
  final FavoriteLocalDatasource favorites;

  List<Country> _countries = [];
  Set<String> _favoriteIds = {};

  CountryBloc(this.repository, this.favorites) : super(CountryInitial()) {
    on<FetchCountries>(_onFetchCountries);
    on<LoadFavorites>(_onLoadFavorites);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<CountryState> emit,
  ) async {
    _favoriteIds = await favorites.getFavoritesIds();
  }

  Future<void> _onFetchCountries(
    FetchCountries event,
    Emitter<CountryState> emit,
  ) async {
    emit(CountryLoading());

    try {
      _countries = await repository.getAllCountries();
      emit(CountryLoaded(_countries));
    } catch (e) {
      emit(CountryError(e.toString()));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<CountryState> emit,
  ) async {
    await favorites.toggleFavorite(event.cca2);
    _favoriteIds = await favorites.getFavoritesIds();

    // emit again for UI update
    emit(CountryLoaded(_countries));
  }

  /// A method to check if a country is favorite for UI purposes
  bool isFavorite(String cca2) {
    return _favoriteIds.contains(cca2);
  }
}
