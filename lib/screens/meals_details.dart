import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorite_provider.dart';

class MealsDetailsScreen extends ConsumerWidget {
  const MealsDetailsScreen({
    super.key,
    required this.meal,
    // required this.onToggleFavorite,
  });

  final Meal meal;
  // final void Function(Meal meal)? onToggleFavorite;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritMeals = ref.watch(favoritMealsProvider);
     final isFavorit= favoritMeals.contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              // onToggleFavorite!(meal);
             final wasAdded = ref
                  .read(favoritMealsProvider.notifier)
                  .toggleMealFavotieStatus(meal); 
                  ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(wasAdded ? "Meal Added as a favorite" : "Meal Removed")));
            },
            icon: Icon(isFavorit ?  Icons.star : Icons.star_border ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 14),
            Text(
              "Ingredients:",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 14),
            for (final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            const SizedBox(height: 24),
            Text(
              "Steps:",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 14),
            for (final step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
