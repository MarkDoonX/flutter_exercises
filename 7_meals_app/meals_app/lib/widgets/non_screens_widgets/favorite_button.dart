import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  FavoriteButton(
      {@required this.mealId,
      @required this.toggleFavorite,
      @required this.isMealAFavorite});

  final String mealId;
  final Function toggleFavorite;
  final Function isMealAFavorite;

  @override
  Widget build(BuildContext context) {
    return isMealAFavorite(mealId)
        ? IconButton(
            icon: Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: Align(
                alignment: Alignment.center,
                // child: Text('A'),
                child: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
            ),
            onPressed: () => toggleFavorite(mealId),
          )
        : IconButton(
            icon: Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: Align(
                alignment: Alignment.center,
                // child: Text('A'),
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
              ),
            ),
            onPressed: () => toggleFavorite(mealId),
          );
  }
}
