import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoriteProvider extends StateNotifier<List<Meal>> {
  FavoriteProvider() : super([]);

  bool toggleFavMeal(Meal meal) {
    final exists = state.contains(meal);

    if (exists) {
      state = state.where((m) => m != meal).toList();
      return true;
    } else {
      state = [...state, meal];
      return false;
    }
  }
}

final favoriteMealsProvider = StateNotifierProvider<FavoriteProvider, List<Meal>>((ref) {
  return FavoriteProvider();
});
