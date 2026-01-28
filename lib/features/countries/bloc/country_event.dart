abstract class CountryEvent {}

class FetchCountries extends CountryEvent {}

class FetchCountryDetails extends CountryEvent {
  final String cca2;

  FetchCountryDetails(this.cca2);
}

class SearchCountries extends CountryEvent {
  final String query;

  SearchCountries(this.query);
}

class ToggleFavorite extends CountryEvent {
  final String cca2;

  ToggleFavorite(this.cca2);
}

class LoadFavorites extends CountryEvent {}
