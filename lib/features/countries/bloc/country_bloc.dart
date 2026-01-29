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

  CountryBloc(this.repository, this.favorites) : super(const CountryState()) {
    on<FetchCountries>(_onFetchCountries);
    on<LoadFavorites>(_onLoadFavorites);
    on<ToggleFavorite>(_onToggleFavorite);
    on<SearchCountries>(_onSearchCountries);
    on<FetchCountryDetails>(_onFetchCountryDetails);
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<CountryState> emit,
  ) async {
    _favoriteIds = await favorites.getFavoritesIds();
    emit(state.copyWith());
  }

  Future<void> _onFetchCountries(
    FetchCountries event,
    Emitter<CountryState> emit,
  ) async {
    emit(state.copyWith(isLoadingCountries: true, errorMessage: null));

    try {
      _countries = await repository.getAllCountries();
      emit(state.copyWith(countries: _countries, isLoadingCountries: false));
    } catch (e) {
      emit(
        state.copyWith(isLoadingCountries: false, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<CountryState> emit,
  ) async {
    await favorites.toggleFavorite(event.cca2);
    _favoriteIds = await favorites.getFavoritesIds();
    emit(state.copyWith(errorMessage: null));
  }

  Future<void> _onSearchCountries(
    SearchCountries event,
    Emitter<CountryState> emit,
  ) async {
    final query = event.query.toLowerCase();

    if (query.isEmpty) {
      emit(state.copyWith(countries: _countries, errorMessage: null));
      return;
    }

    final filtered = _countries
        .where((c) => c.name.toLowerCase().contains(query))
        .toList();

    emit(state.copyWith(countries: filtered, errorMessage: null));
  }

  Future<void> _onFetchCountryDetails(
    FetchCountryDetails event,
    Emitter<CountryState> emit,
  ) async {
    emit(state.copyWith(isLoadingDetail: true, errorMessage: null));

    try {
      final country = await repository.getCountryDetails(event.cca2);
      emit(state.copyWith(selectedCountry: country, isLoadingDetail: false));
    } catch (e) {
      emit(state.copyWith(isLoadingDetail: false, errorMessage: e.toString()));
    }
  }

  bool isFavorite(String cca2) {
    return _favoriteIds.contains(cca2);
  }
}
