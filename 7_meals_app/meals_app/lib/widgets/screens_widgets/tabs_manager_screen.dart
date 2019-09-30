import 'package:flutter/material.dart';

import './tabs_bottom_screen.dart';
import './tabs_top_screen.dart';
import '../../models/meals.dart';

class TabsManagerScreen extends StatefulWidget {
  TabsManagerScreen({
    @required this.isBottomTabsDisplayed,
    @required this.switchTabsMode,
    @required this.favoriteMeals,
    @required this.isMealAFavorite,
    @required this.toggleFavorite,
  });

  final bool isBottomTabsDisplayed;
  final Function switchTabsMode;
  final List<Meal> favoriteMeals;
  final Function toggleFavorite;
  final Function isMealAFavorite;

  @override
  _TabsManagerScreenState createState() => _TabsManagerScreenState();
}

class _TabsManagerScreenState extends State<TabsManagerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.isBottomTabsDisplayed
          ? TabsScreenBottom(
              isMealAFavorite: widget.isMealAFavorite,
              toggleFavorite: widget.toggleFavorite,
              switchTabsMode: widget.switchTabsMode,
              isBottomTabsDisplayed: widget.isBottomTabsDisplayed,
              favoriteMeals: widget.favoriteMeals,
            )
          : TabsScreenTop(
              isMealAFavorite: widget.isMealAFavorite,
              toggleFavorite: widget.toggleFavorite,
              switchTabsMode: widget.switchTabsMode,
              isBottomTabsDisplayed: widget.isBottomTabsDisplayed,
              favoriteMeals: widget.favoriteMeals,
            ),
    );
  }
}
