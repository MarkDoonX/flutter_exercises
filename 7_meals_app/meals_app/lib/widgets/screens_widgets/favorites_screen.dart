import 'package:flutter/material.dart';

import '../../models/meals.dart';
import '../non_screens_widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({
    @required this.favoriteMeals,
    @required this.toggleFavorite,
    @required this.isMealAFavorite,
  });

  final List<Meal> favoriteMeals;
  final Function toggleFavorite;
  final Function isMealAFavorite;

  @override
  Widget build(BuildContext context) {
    print('Building Favorites Screen');
    return ListView.builder(
      itemBuilder: (context, index) {
        return MealItem(
          meal: favoriteMeals[index],
          isMealAFavorite: isMealAFavorite,
          toggleFavorite: toggleFavorite,
        );
      },
      itemCount: favoriteMeals.length,
    );
  }
}
