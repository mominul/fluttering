import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/models/meal.dart';
import 'package:meals/providers/favourites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  void showMessage(String message, context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFav = ref.watch(favoriteMealsProvider).contains(meal);
    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
          actions: [
            IconButton(
                icon: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: Icon(
                    isFav ? Icons.star : Icons.star_border,
                    key: ValueKey(isFav),
                  ),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                ),
                onPressed: () {
                  final exists = ref
                      .read(favoriteMealsProvider.notifier)
                      .toggleFavMeal(meal);

                  if (exists) {
                    showMessage(
                        'Removed \'${meal.title}\' from favorites!', context);
                  } else {
                    showMessage(
                        'Added \'${meal.title}\' to favorites!', context);
                  }
                }),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: meal.id,
                child: Image.network(
                  meal.imageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 14),
              for (final ingredient in meal.ingredients)
                Text(
                  ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              const SizedBox(height: 24),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 14),
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
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                ),
            ],
          ),
        ));
  }
}
