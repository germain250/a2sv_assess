import 'package:discover/features/countries/data/datasources/country_remote_datasource.dart';
import 'package:discover/features/countries/domain/entities/country.dart';
import 'package:discover/features/countries/domain/repositories/country_repository.dart';

class CountryRepositoryImpl implements CountryRepository {
  final CountryRemoteDatasource remoteDatasource;

  CountryRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<Country>> getAllCountries() async {
    return await remoteDatasource.getAllCountries();
  }

  @override
  Future<Country> getCountryDetails(String cca2) async {
    return await remoteDatasource.getCountryDetails(cca2);
  }
}
