import 'package:discover/core/theme/theme_cubit.dart';
import 'package:discover/core/widgets/bottom_bar_item.dart';
import 'package:discover/core/widgets/empty_state.dart';
import 'package:discover/features/countries/bloc/country_bloc.dart';
import 'package:discover/features/countries/bloc/country_event.dart';
import 'package:discover/features/countries/bloc/country_state.dart';
import 'package:discover/features/countries/presentation/screens/country_details_screen.dart';
import 'package:discover/features/countries/presentation/widgets/country_card.dart';
import 'package:discover/features/countries/presentation/widgets/country_search_bar.dart';
import 'package:discover/features/countries/presentation/widgets/skeleton_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<Map<String, String>> items = [
    {"icon": "assets/icons/home.svg", "label": "Home"},
    {"icon": "assets/icons/favorites.svg", "label": "Favorite"},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state;
    final bloc = context.read<CountryBloc>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Row(
                children: [
                  const Opacity(
                    opacity: 0,
                    child: Switch(value: false, onChanged: null),
                  ),
                  Expanded(
                    child: Text(
                      selectedIndex == 0 ? 'Countries' : 'Favorites',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Switch(
                    value: isDark,
                    onChanged: (_) {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                  ),
                ],
              ),
            ),

            Expanded(
              child: IndexedStack(
                index: selectedIndex,
                children: [
                  Column(
                    children: [
                      CountrySearchBar(
                        onSearchChanged: (query) {
                          bloc.add(SearchCountries(query));
                        },
                      ),
                      Expanded(
                        child: BlocBuilder<CountryBloc, CountryState>(
                          builder: (context, state) {
                            if (state is CountryLoading) {
                              return ListView.builder(
                                itemCount: 8,
                                itemBuilder: (_, __) => const CountrySkeleton(),
                              );
                            }

                            if (state is CountryError) {
                              return EmptyState(
                                cs: Theme.of(context).colorScheme,
                                title: "Hmmmmm Try again",
                                description:
                                    "Please try again after checking network connectivity",
                                icon: Icons.network_check,
                              );
                            }

                            if (state is CountryLoaded) {
                              if (state.countries.isEmpty) {
                                return EmptyState(
                                  cs: Theme.of(context).colorScheme,
                                  title: "No countries found",
                                  description: "Try a different search",
                                  icon: Icons.search_off,
                                );
                              }

                              return RefreshIndicator(
                                onRefresh: () async {
                                  bloc.add(FetchCountries());
                                },
                                child: ListView.builder(
                                  itemCount: state.countries.length,
                                  itemBuilder: (context, index) {
                                    return CountryCard(
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) {
                                            return CountryDetailScreen(
                                              cca2: state.countries[index].cca2,
                                            );
                                          },
                                        ),
                                      ),
                                      country: state.countries[index],
                                    );
                                  },
                                ),
                              );
                            }

                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<CountryBloc, CountryState>(
                    builder: (context, state) {
                      if (state is CountryLoading) {
                        return ListView.builder(
                          itemCount: 6,
                          itemBuilder: (_, __) => const CountrySkeleton(),
                        );
                      }

                      if (state is CountryLoaded) {
                        final favorites = state.countries
                            .where((c) => bloc.isFavorite(c.cca2))
                            .toList();

                        if (favorites.isEmpty) {
                          return EmptyState(
                            cs: Theme.of(context).colorScheme,
                            title: "No Favorites yet",
                            description:
                                "Browse countries and add to Favorite!",
                            icon: Icons.hourglass_empty_outlined,
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    setState(() => selectedIndex = 0),
                                child: const Text("View Countries"),
                              ),
                            ],
                          );
                        }

                        return RefreshIndicator(
                          onRefresh: () async {
                            bloc.add(FetchCountries());
                          },
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: favorites.length,
                            itemBuilder: (context, index) {
                              return CountryCard(country: favorites[index]);
                            },
                          ),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      //The bottom appbar
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(width: 0.2)),
          ),
          child: BottomAppBar(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height * 0.13,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(items.length, (index) {
                return BottomBarItem(
                  iconPath: items[index]["icon"]!,
                  label: items[index]["label"]!,
                  isActive: selectedIndex == index,
                  onTap: () => setState(() {
                    selectedIndex = index;
                  }),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
