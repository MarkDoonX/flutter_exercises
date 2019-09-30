import 'package:flutter/material.dart';

import '../../models/meals.dart';
import '../non_screens_widgets/meal_item.dart';

// We need to be StatefulWidget here to be able use initState()/didChangeDependencies()
// and use setState()
class CategoryMealsScreen extends StatefulWidget {
  /// This is a good practice to set the Route to a widget
  /// as a static const (to be accessed from anywhere without instanciating)
  static const String selfRoute = '/category-meals';

  CategoryMealsScreen({
    @required this.availableMeals,
    @required this.toggleFavorite,
    @required this.isMealAFavorite,
  });

  final List<Meal> availableMeals;
  final Function toggleFavorite;
  final Function isMealAFavorite;

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  /// Getting rid of the constructor since now we wont pass data through arguments
  /// We get the required data through [ModalRoute] here!
  ///
  /// the arguments have been passed from [category_item.dart] using Navigator
  String categoryTitle;
  List<Meal> listOfCategoryMeals;
  bool wasDidChangeDependenciesAlreadyCalled = false;

  // We can't use [ModalRoute.of(context)] in [initState()] because initState() is
  // called before the context is created
  // Hence in this case we have to use [didChangeDependencies()] instead
  @override
  void initState() {
    // final routeArgs =
    //   ModalRoute.of(context).settings.arguments as Map<String, String>;
    // final categoryId = routeArgs['id'];
    // categoryTitle = routeArgs['title'];
    // listOfCategoryMeals = dummyMeals.where((meal) {
    //   return meal.categories.contains(categoryId);
    // }).toList();
    super.initState();
  }

  // [didChangeDependencies()] fires after [initState()], which creates the context so
  // it is now usable
  // Problem is it gets call when we get back to this Screen after we poped a meal description Screen
  // because it is calledd when we do a [setState()]
  // That's why i use a boolean to block [didChangeDependencies()] once it was fired once
  @override
  void didChangeDependencies() {
    if (!wasDidChangeDependenciesAlreadyCalled) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      final categoryId = routeArgs['id'];
      categoryTitle = routeArgs['title'];
      // .toList() is very important to transform the Iterable<Meal> into a List<Meal> !
      // otherwise, it would be impossible to access data bata the index!
      // Here, we Select a List<Meal> from dummyMeals in dumy_data.dart
      // where Meals hold the category of the current Meal Category
      listOfCategoryMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      wasDidChangeDependenciesAlreadyCalled = true;
    }

    super.didChangeDependencies();
  }

  removeMeal(String mealId) {
    setState(() {
      listOfCategoryMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('$categoryTitle Recipes'),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            /// We pass to each MealItem, the corresponding [meal] object
            /// that holds its full info
            return MealItem(
              meal: listOfCategoryMeals[index],
              removeItem: removeMeal,
              isMealAFavorite: widget.isMealAFavorite,
              toggleFavorite: widget.toggleFavorite,
            );
          },
          itemCount: listOfCategoryMeals.length,
        ));
  }
}
