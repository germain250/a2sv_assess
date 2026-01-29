import 'package:discover/features/countries/bloc/country_bloc.dart';
import 'package:discover/features/countries/bloc/country_event.dart';
import 'package:discover/features/countries/domain/entities/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryCard extends StatelessWidget {
  final Country country;
  final VoidCallback? onTap;

  const CountryCard({super.key, required this.country, this.onTap});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CountryBloc>();
    final isFavorite = bloc.isFavorite(country.cca2);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      hoverColor: Theme.of(context).cardColor,
      
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  country.flag,
                  width: 56,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 56,
                    height: 40,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      country.name,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatPopulation(country.population),
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  bloc.add(ToggleFavorite(country.cca2));
                },
                splashRadius: 20,
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.grey.shade300 : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // A function that formats th population

  String _formatPopulation(population) {
    if (population >= 1000000) {
      return "Population: ${(population / 1000000).toStringAsFixed(1)}M";
    } else if (population >= 1000) {
      return "Population: ${(population / 1000).toStringAsFixed(1)}K";
    }

    return "Population: $population";
  }
}
