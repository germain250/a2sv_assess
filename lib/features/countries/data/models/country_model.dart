import '../../domain/entities/country.dart';

class CountryModel extends Country {
  const CountryModel({
    required super.name,
    required super.flag,
    required super.population,
    required super.cca2,
    super.capital,
    super.region,
    super.subregion,
    super.area,
    super.timezones,
  });

  /// Gets the first fetch's summary data

  factory CountryModel.fromSummaryJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name']['common'],
      flag: json['flags']['png'],
      population: json['population'],
      cca2: json['cca2'],
    );
  }

  /// Used for the detailed fetch
  factory CountryModel.fromDetailsJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name']['common'],
      flag: json['flags']['png'],
      population: json['population'],
      cca2: json['cca2'],
      capital: (json['capital'] as List?)?.first,
      region: json['region'],
      subregion: json['subregion'],
      area: (json['area'] as num?)?.toDouble(),
      timezones: (json['timezones'] as List?)
          ?.map((e) => e.toString())
          .toList(),
    );
  }
}
