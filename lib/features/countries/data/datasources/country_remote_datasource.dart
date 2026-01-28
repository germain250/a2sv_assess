import 'package:discover/core/network/api_client.dart';
import 'package:discover/features/countries/data/models/country_model.dart';

abstract class CountryRemoteDatasource {
  Future<List<CountryModel>> getAllCountries();
  Future<CountryModel> getCountryDetails(String cca2);
}

class CountryRemoteDatasourceImpl implements CountryRemoteDatasource {
  final ApiClient apiClient;

  CountryRemoteDatasourceImpl(this.apiClient);

  static const String baseUrl = "https://restcountries.com/v3.1";

  @override
  Future<List<CountryModel>> getAllCountries() async {
    final response = await apiClient.get(
      "$baseUrl/all?fields=name,flags,population,cca2",
    );

    return (response as List)
        .map((e) => CountryModel.fromSummaryJson(e))
        .toList();
  }

  @override
  Future<CountryModel> getCountryDetails(String cca2) async {
    final response = await apiClient.get("$baseUrl/alpha/$cca2");

    return CountryModel.fromDetailsJson(response[0]);
  }
}
