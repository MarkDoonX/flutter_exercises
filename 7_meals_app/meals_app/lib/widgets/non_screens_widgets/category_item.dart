/// Notable features in this file:
///
/// - [EdgeInsets] = padding/margin =
/// - [BoxDecoration] = Container's color, image, border, etc ...
///   -> [BorderDirectional] = Manage border independently
///       -> [BorderSide] = single border setup
/// - [ gradient: LinearGradient] = Apply colors gradients to a Container

import 'package:flutter/material.dart';

import '../screens_widgets/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem({
    @required this.id,
    @required this.title,
    @required this.color,
  });

  final String id;
  final String title;
  final Color color;

  /// Function to Re-Direct to a non-named route
  ///
  /// Keeping it as an example
  ///
  // void _selectCategory(BuildContext ctx) {
  //   Navigator.of(ctx).push(
  //     MaterialPageRoute(
  //       builder: (_) {
  //         return CategoryMealsScreen(categoryId: id, categoryTitle: title,);
  //       },
  //     ),
  //   );
  // }

  /// Function to redirect to a named route, with arguments given here and not in route definition
  /// in main.dart
  ///
  /// This Navigation redirects to a Named Route that also needs arguments!
  /// [CategoryMealsScreen] needs a [categoryId] and a [categoryTitle]
  /// we then can pass the arguments to it by using the [arguments] preperty
  /// we can pass any object as arguments: in our case a [map<String, String>]
  ///
  void _selectCategory(BuildContext ctx) {
    Navigator.pushNamed(ctx, CategoryMealsScreen.selfRoute, arguments: {
      'id': id,
      'title': title,
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectCategory(context),
      splashColor: color,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.title,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),

          /// BorderRadius can only be set if borders are uniform
          ///
          // border: BorderDirectional(
          //   end: BorderSide(
          //     color: color.withOpacity(0.25),
          //     width: 10,
          //   ),
          //   start: BorderSide(
          //     color: color.withOpacity(0.25),
          //     width: 10,
          //   ),
          // ),

          // gradient takes a list of colors and makes gradiants between each of them
          // it's then possible to do interesting combinations
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.80),
              color.withOpacity(0.75),
              color.withOpacity(0.60),
              color.withOpacity(0.55),
              color.withOpacity(0.50),
              color.withOpacity(0.45),
              color.withOpacity(0.40),
              color.withOpacity(0.30),
              color.withOpacity(0.20),
              color.withOpacity(0.15),
              color.withOpacity(0.10),
              color.withOpacity(0.80),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}
