import 'package:discover/core/theme/theme_cubit.dart';
import 'package:discover/features/countries/bloc/country_bloc.dart';
import 'package:discover/features/countries/bloc/country_event.dart';
import 'package:discover/features/countries/bloc/country_state.dart';
import 'package:discover/features/countries/presentation/widgets/country_details_skeleton.dart';
import 'package:discover/features/countries/presentation/widgets/stat_row.dart';
import 'package:discover/features/countries/presentation/widgets/timezone_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryDetailScreen extends StatefulWidget {
  final String cca2;

  const CountryDetailScreen({super.key, required this.cca2});

  @override
  State<CountryDetailScreen> createState() => _CountryDetailScreenState();
}

class _CountryDetailScreenState extends State<CountryDetailScreen> {
  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() {
    context.read<CountryBloc>().add(FetchCountryDetails(widget.cca2));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state;

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CountryBloc, CountryState>(
          builder: (context, state) {
            // Loading
            if (state.isLoadingDetail) {
              return const CountryDetailSkeleton();
            }

            // Error
            if (state.errorMessage != null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    state.errorMessage!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              );
            }

            // No data loaded yet
            final country = state.selectedCountry;
            if (country == null) {
              return const Center(child: Text('No country data available'));
            }

            // Success → show content
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                  child: Row(
                    children: [
                      const BackButton(),

                      Expanded(
                        child: Text(
                          country.name,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),

                      const SizedBox(width: 48),
                    ],
                  ),
                ),

                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async => _fetch(),
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image.network(
                              country.flag,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image, size: 80),
                            ),
                          ),
                        ),

                        const SizedBox(height: 28),

                        Text(
                          "Key Statistics",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 20),

                        StatRow(label: "Area", value: "${country.area} sq km"),
                        StatRow(
                          label: "Population",
                          value:
                              "${(country.population / 1000000).toStringAsFixed(1)} million",
                        ),
                        StatRow(
                          label: "Region",
                          value: country.region ?? "N/A",
                        ),
                        StatRow(
                          label: "Sub Region",
                          value: country.subregion ?? "N/A",
                        ),

                        const SizedBox(height: 40),

                        Text(
                          "Timezones",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),

                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: (country.timezones ?? [])
                              .map(
                                (tz) => TimezoneChip(label: tz, isDark: isDark),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
