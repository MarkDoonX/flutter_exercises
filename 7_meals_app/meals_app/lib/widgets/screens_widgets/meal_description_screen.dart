import 'package:flutter/material.dart';

import '../../models/meals.dart';
import '../non_screens_widgets/favorite_button.dart';

class MealDescriptionScreen extends StatelessWidget {
  static const String selfRoute = "/meals-description";

  MealDescriptionScreen(
      {@required this.toggleFavorite, @required this.isMealAFavorite});

  final Function toggleFavorite;
  final Function isMealAFavorite;

  /// Builder Method for Section Titles
  ///
  Widget buildSectionTitle({
    @required BuildContext context,
    @required String title,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  /// Builder Method for Section Containers
  ///
  /// This Contaier will contain the Lists of Data picked from the [Meal] object
  /// (Here Ingredients or Steps)
  Widget buildSectionContainer({@required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      height: 150,
      width: 400,
      child: child,
    );
  }

  /// BUILD WIDGET
  ///
  @override
  Widget build(BuildContext context) {
    /// [meal] is the Instance of Meal that corresponds to this [MealDescriptionScreen]
    /// It contains all the parameters that describe the current meal
    ///
    final Meal meal = ModalRoute.of(context).settings.arguments as Meal;

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: <Widget>[
          FavoriteButton(
            isMealAFavorite: isMealAFavorite,
            mealId: meal.id,
            toggleFavorite: toggleFavorite,
          )
        ],
      ),

      /// [SingleChildScrollView()] is used here to permit to make the page scrollable
      /// if the content goes out of visible screen
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),

            /// INGREDIENTS
            ///
            /// Section Title
            buildSectionTitle(context: context, title: 'Ingredients'),

            /// List of [meal.ingredients]
            ///
            /// [ListView] becomes automatically scrollable if its container can't hold all of
            /// the listed widgets
            buildSectionContainer(
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        meal.ingredients[index],
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ),
                  );
                },
                itemCount: meal.ingredients.length,
              ),
            ),

            /// STEPS
            ///
            /// Section Title
            buildSectionTitle(context: context, title: 'Steps'),

            /// List of [meal.steps]
            buildSectionContainer(
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return Column(
                    children: <Widget>[
                      /// List Items
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Text("#${index + 1}"),
                        ),
                        title: Container(
                          child: Text(
                            meal.steps[index],
                            style: Theme.of(context).textTheme.body1,
                          ),
                        ),
                      ),

                      /// Spacing
                      Divider(
                        color: Colors.grey,
                        height: 20,
                      ),
                    ],
                  );
                },
                itemCount: meal.steps.length,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () {
          // pop() result can take any kind of object
          // this result will be available to the page we are comming from!
          Navigator.pop(context, meal.id);
        },
      ),
    );
  }
}
