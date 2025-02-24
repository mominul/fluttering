import 'package:flutter/material.dart';

import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/category.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/widgets/category_grid_items.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.filteredMeals});

  final List<Meal> filteredMeals;

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(context, Category category) {
    final filtered = widget.filteredMeals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
      return MealsScreen(
        title: category.title,
        meals: filtered,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    final count = MediaQuery.of(context).size.width > 600 ? 3 : 2;
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
          padding: const EdgeInsets.all(20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: [
            for (final category in availableCategories)
              CategoryGridItem(
                category: category,
                onTap: () => _selectCategory(context, category),
              ),
          ],
        ),
        builder: (ctx, child) => SlideTransition(
              position: Tween(
                begin: const Offset(0, 0.3),
                end: const Offset(0, 0),
              ).animate(CurvedAnimation(
                  parent: _animationController, curve: Curves.easeInOut)),
              child: child,
            ));
  }
}
