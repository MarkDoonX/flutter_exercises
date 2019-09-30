import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './dummy_data.dart';
import './models/meals.dart';
import './widgets/screens_widgets/categories_screen.dart';
import './widgets/screens_widgets/category_meals_screen.dart';
import './widgets/screens_widgets/meal_description_screen.dart';
import './widgets/screens_widgets/tabs_manager_screen.dart';
import './widgets/screens_widgets/filters_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten-free': false,
    'vegetarian': false,
    'vegan': false,
    'lactose-free': false,
  };

  List<Meal> _availableMeals = dummyMeals;

  List<Meal> _favoriteMeals = [];

  bool isBottomTabsDisplayed = false;

  void _switchTabsMode(bool boolState) {
    setState(() {
      isBottomTabsDisplayed = boolState;
    });
  }

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = dummyMeals.where((meal) {
        if (_filters['gluten-free'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['lactose-free'] && !meal.isLactoseFree) {
          return false;
        } else {
          return true;
        }
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    // indexWhere() returns -1 if the bool is false
    final int existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
      // Testing removing from phone
      removeFavoritesInPhone(mealId);
    } else {
      setState(() {
        _favoriteMeals.add(dummyMeals.firstWhere((meal) => meal.id == mealId));
      });
      // Testing adding to phone
      addFavoritesInPhone();
    }
  }

  bool _isMealAFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  // ***** TESTING PHONE STORAGE
  // **********************************************************
  // **********************************************************
  List<String> favoritesIdList = [];

  void loadFavoritesKeysFromPhone()  async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      favoritesIdList = prefs.getKeys().toList();
    });
    if (favoritesIdList.length > 0){
      populateFavoriteMealsWithDataFromPhone();
      print("test");
    }
  }

  void populateFavoriteMealsWithDataFromPhone() {
    setState(() {
      favoritesIdList.forEach((mealId) {
        _favoriteMeals.add(dummyMeals.firstWhere((meal) => meal.id == mealId));
      });
    });
  }

  void addFavoritesInPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _favoriteMeals.forEach((meal) {
        prefs.setString(meal.id, meal.id);
      });
    });
  }

  void removeFavoritesInPhone(String mealId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.remove(mealId);
    });
  }

  @override
  void initState(){
    loadFavoritesKeysFromPhone();
    super.initState();
  }
  // **********************************************************
  // **********************************************************
  // **********************************************************

  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      title: 'Meals',
      theme: ThemeData(
        // primary Swatch can be called with primaryColor to get the initial color
        // and not a swatch of it
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        // it's the color of the page's background
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 50, 50, 1),
                fontSize: 17.5,
              ),
              body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              title: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      home: TabsManagerScreen(
        isMealAFavorite: _isMealAFavorite,
        toggleFavorite: _toggleFavorite,
        isBottomTabsDisplayed: isBottomTabsDisplayed,
        switchTabsMode: _switchTabsMode,
        favoriteMeals: _favoriteMeals,
      ), // home Toute is '/' by default

      /// NAMED ROUTES ===> See [categories_screen.dart] for usage
      /// ************************************************
      ///
      /// Using named routes like this is a good pratice over non-named routes
      /// it is cleaner and more organised
      ///
      initialRoute:
          '/', // is not required since '/' automatically is the initialRoute
      routes: <String, WidgetBuilder>{
        CategoryMealsScreen.selfRoute: (ctx) => CategoryMealsScreen(
            isMealAFavorite: _isMealAFavorite,
            toggleFavorite: _toggleFavorite,
            availableMeals: _availableMeals), // '/category-meals'
        MealDescriptionScreen.selfRoute: (ctx) => MealDescriptionScreen(
              toggleFavorite: _toggleFavorite,
              isMealAFavorite: _isMealAFavorite,
            ), // 'meals-description'
        FiltersScreen.selfRoute: (ctx) => FiltersScreen(
            saveFilters: _setFilters, currentFilters: _filters), // '/filters'
      },

      /// onGenerateRoute's function is called when we use Navigator.pushNamed() on a Toute that
      /// is not listed in routes above
      /// --> comment [MealDescriptionScreen.selfRoute:] in routes: it will use onGenerateRoute's function
      ///     and re-direct to the chosen screen
      ///
      /// We dont need it in this app, but it's here for the example
      /// It is usefeul on App i which we will generate routes dynamically
      /// from settings, we can also access the name of the route we tried to push:
      /// setting.name. and do things depending on route name, etc,..
      onGenerateRoute: (settings) {
        /// EXAMPLE using settings.arguments
        ///
        // final meal = settings.arguments as Meal;
        // print("Meal Id = ${meal.id}");
        // print("Meal Duration = ${meal.duration}");
        // print("Meal Title = ${meal.title}");

        /// EXAMPLE using settings.name
        ///
        // if (settings.name == '/some-named-route')
        //   return ...;
        // else if (settings.name == 'other-named-route')
        //   return ...;
        // //etc,...

        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },

      /// Is used when we try to push a route that is unusable
      /// generally we use it to redirectto an Error page or something similar
      /// It's a good practice to use this
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      // *************************************************
    );
  }
}
