/// TOP TABS
///
/// TOP TABS WORKFlow:
/// -> return [DefaultTabController]
/// -> need to use [Scaffold] as child, to be able to use
///    parameter appBar: [Appbar](botom: [AppBar](tabs: <Widget>[Tab(), Tab(),],))
/// -> make a list of [Tab()] with icons and names as options
/// -> in Scaffold(body: ,)
///

import 'package:flutter/material.dart';

import './categories_screen.dart';
import './favorites_screen.dart';
import '../non_screens_widgets/switch_tabs.dart';
import '../non_screens_widgets/main_drawer.dart';
import '../../models/meals.dart';

/// For TOP TABS, no need to be Stateful,
/// But Stateful is needed for BOTTOM TABS

class TabsScreenTop extends StatefulWidget {
  TabsScreenTop(
      {@required this.switchTabsMode,
      @required this.isBottomTabsDisplayed,
      @required this.favoriteMeals,
      @required this.toggleFavorite,
      @required this.isMealAFavorite});

  final void Function(bool boolState) switchTabsMode;
  final bool isBottomTabsDisplayed;
  final List<Meal> favoriteMeals;
  final Function toggleFavorite;
  final Function isMealAFavorite;

  @override
  _TabsScreenTopState createState() => _TabsScreenTopState();
}

class _TabsScreenTopState extends State<TabsScreenTop> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      /// defines which Tab to show first!

      initialIndex: 0,
      length: 2,
      child: Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          actions: <Widget>[
            SwitchTabs(
              switchTabsMode: widget.switchTabsMode,
              isBottomTabsDisplayed: widget.isBottomTabsDisplayed,
            ),
          ],
          // title: Text('test'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.category),
                text: 'Categories',
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Favorites',
              ),
            ],
          ),
        ),

        /// In [TabBarView] List, each Widget is linked to the [Tab] in
        /// same posistion in [TabBar]
        ///
        /// For example here [CategoriesScreen] in position [0] refers to
        /// [Tab] in position [0] in [TabBar] List
        body: TabBarView(
          children: <Widget>[
            CategoriesScreen(),
            FavoritesScreen(
              isMealAFavorite: widget.isMealAFavorite,
              toggleFavorite: widget.toggleFavorite,
              favoriteMeals: widget.favoriteMeals,
            ),
          ],
        ),
      ),
    );
  }
}
