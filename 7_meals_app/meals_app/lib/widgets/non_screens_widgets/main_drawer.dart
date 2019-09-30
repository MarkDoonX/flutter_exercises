/// DRAWER =  Side Menu
///
/// Drawer here is used in 'drawer: ' argument of a Scaffold

import 'package:flutter/material.dart';

import '../screens_widgets/filters_screen.dart';



class MainDrawer extends StatelessWidget {

  // MainDrawer({@required this.isBottomTabsDisplayed});

  // final bool isBottomTabsDisplayed;

  /// Widget Builder Method
  /// 
  /// we could also create a StatelessWidget in an other file, or in this file
  /// Instead of making a Builder Method => this would be a better practice
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 25,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: Column(
        children: <Widget>[
          /// TITLE
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: Theme.of(context).primaryColor),
            ),
          ),

          /// Spacing
          SizedBox(
            height: 20,
          ),

          /// MEALS
          buildListTile(
            'Meals',
            Icons.restaurant,
            () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),

          /// FILTERS
          buildListTile(
            'Filters',
            Icons.settings,
            () {
              Navigator.of(context)
                  .pushReplacementNamed(FiltersScreen.selfRoute);
            },
          ),
        ],
      ),
    );
  }
}
