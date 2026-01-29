import 'package:discover/core/theme/theme_cubit.dart';
import 'package:discover/features/countries/bloc/country_bloc.dart';
import 'package:discover/features/countries/bloc/country_event.dart';
import 'package:discover/features/countries/bloc/country_state.dart';
import 'package:discover/features/countries/presentation/widgets/country_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Countries"),
        centerTitle: true,
        actions: [
          Switch(
            value: isDark,
            onChanged: (_) {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SearchBar(
              onChanged: (query) {
                context.read<CountryBloc>().add(SearchCountries(query));
              },
            ),
            Expanded(
              child: BlocBuilder<CountryBloc, CountryState>(
                builder: (context, state) {
                  if (state is CountryLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is CountryError) {
                    return Center(child: Text(state.message));
                  }

                  if (state is CountryLoaded) {
                    if (state.countries.isEmpty) {
                      return Center(child: Text("No Countries Found"));
                    }
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final country = state.countries[index];
                        return CountryCard(country: country);
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
