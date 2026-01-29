import 'package:equatable/equatable.dart';
import 'package:discover/features/countries/domain/entities/country.dart';

class CountryState extends Equatable {
  final List<Country> countries;
  final bool isLoadingCountries;
  final Country? selectedCountry;
  final bool isLoadingDetail;
  final String? errorMessage;

  const CountryState({
    this.countries = const [],
    this.isLoadingCountries = false,
    this.selectedCountry,
    this.isLoadingDetail = false,
    this.errorMessage,
  });

  CountryState copyWith({
    List<Country>? countries,
    bool? isLoadingCountries,
    Country? selectedCountry,
    bool? isLoadingDetail,
    String? errorMessage,
  }) {
    return CountryState(
      countries: countries ?? this.countries,
      isLoadingCountries: isLoadingCountries ?? this.isLoadingCountries,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      isLoadingDetail: isLoadingDetail ?? this.isLoadingDetail,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;

  @override
  List<Object?> get props => [
    countries,
    isLoadingCountries,
    selectedCountry,
    isLoadingDetail,
    errorMessage,
  ];
}
