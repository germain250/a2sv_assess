import 'package:discover/features/countries/domain/entities/country.dart';

abstract class CountryRepository {
  Future<List<Country>> getAllCountries();
  Future<Country> getCountryDetails(String cca2);
}
