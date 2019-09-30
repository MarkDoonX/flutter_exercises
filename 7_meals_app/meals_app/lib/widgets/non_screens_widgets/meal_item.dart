import 'package:flutter/material.dart';
import '../screens_widgets/meal_description_screen.dart';

import '../../models/meals.dart';
import './favorite_button.dart';

class MealItem extends StatelessWidget {
  MealItem(
      {@required this.meal,
      this.removeItem,
      @required this.toggleFavorite,
      @required this.isMealAFavorite});

  /// [meal] is the Instance of Meal that corresponds to this [MealItem]
  /// It contains all the parameters that describe the current meal
  final Meal meal;
  final Function removeItem;
  final Function toggleFavorite;
  final Function isMealAFavorite;

  /// Getter
  /// This Switch statement permits to make correcspond the Complexity Enum
  /// elements with the wanted trings
  String get complexityText {
    switch (meal.complexity) {
      case Complexity.Simple:
        return 'Simple';
        break;
      case Complexity.Challenging:
        return 'Challenging';
        break;
      case Complexity.Hard:
        return 'Hard';
        break;
      default:
        return 'Unknown';
    }
  }

  String get affordabilityText {
    switch (meal.affordability) {
      case Affordability.Affordable:
        return 'Affordable';
        break;
      case Affordability.Pricey:
        return 'Pricey';
        break;
      case Affordability.Luxurious:
        return 'Luxurious';
        break;
      default:
        return 'Unknown';
    }
  }

  /// Re-directs to the description that corresponds to this MealItem
  ///
  /// we pass a context AND the corresponding instance of meal object
  ///
  /// Futures/async/await/then:
  /// [pushNamed] returns a Future! it's an async method:
  /// it waits for the method the return  something, if it ever returns something
  /// By using pop(result) on the pushed page, we return it to use it here!
  void selectMeal(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
      MealDescriptionScreen.selfRoute,
      arguments: meal,
      // result is the result of pop(result)
    )
        .then((result) {
      removeItem(result);
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                /// THE IMAGE
                ///
                // ClipRRect permits to force the shape of its child
                // here, force topLeft and topRight BorderRadius
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    meal.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: 250,
                      color: Colors.black.withOpacity(0.4),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Text(
                        meal.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: FavoriteButton(
                    mealId: meal.id,
                    isMealAFavorite: isMealAFavorite,
                    toggleFavorite: toggleFavorite,
                  ),
                )
              ],
            ),

            /// THE BOTTOM INFORMATIONS
            ///
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              child: Container(
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.schedule,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${meal.duration} min",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.work,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "$complexityText",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.attach_money,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "$affordabilityText",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
