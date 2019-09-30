/// BOTTOM TABS
///
/// BOTTOM TABS WORKFlow:
///  -> To use a [BottomNavigationBar] the class needs to be stateful
///  -> use [BottomNavigationBar] in the bottomNavigationBar parameter of [Scaffold]
///  -> give [BottomNavigationBar] items that will be the Tabs icons
///  -> give [BottomNavigationBar] an onTap, which will execute a Function(int)
///     we have to manually create that function that has to take an int (index)
///     and store that index in an other variable, with a setState()
///     hence the need to be in a stateful class
///   -> In the body then, give a Widget to render depending on the index given
///      For that, we store our widgets to render in a list
///

import 'package:flutter/material.dart';
import './categories_screen.dart';
import './favorites_screen.dart';
import '../non_screens_widgets/switch_tabs.dart';
import '../non_screens_widgets/main_drawer.dart';
import '../../models/meals.dart';

/// For TOP TABS, no need to be Stateful,
/// But Stateful is needed for BOTTOM TABS
class TabsScreenBottom extends StatefulWidget {
  TabsScreenBottom(
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
  _TabsScreenBottomState createState() => _TabsScreenBottomState();
}

class _TabsScreenBottomState extends State<TabsScreenBottom> {
  /// Used to change the appBar backgroundColor depending on selected Tab
  Color get _appBarBgColor {
    switch (_selectedPageInex) {
      case 0:
        return Theme.of(context).primaryColor;
        break;
      case 1:
        return Colors.blue;
        break;
      default:
        return Theme.of(context).primaryColor;
    }
  }

  // BOTTOM TAB related part **************************************

  // In this list, we could also for example give a list of widgets
  // to use in action property in appBar, and then have different buttons
  // depending on wether we are loading Categories or Favorites!
  List<Map<String, Object>> _pages;

  int _selectedPageInex = 0;

  // I'm forced to set this state after Build() runs, so that FavoriteScreen updates when the widget 
  // rebuilds
  // If i set the state in an initState or didChangeDependencies, it doesnt refreshFavoriteScreen instantly
  // when i click on the favorite button
  //
  // !!! the Build() method being called doesn't necessarly mean that initState() is called before !!!
  void setBuildTimeState() {
    setState(() {
      _pages = [
        {
          'widget': CategoriesScreen(),
          'title': 'Categories',
        },
        {
          'widget': FavoritesScreen(
            isMealAFavorite: widget.isMealAFavorite,
            toggleFavorite: widget.toggleFavorite,
            favoriteMeals: widget.favoriteMeals,
          ),
          'title': 'Favorites',
        },
      ];
    });
  }
 
  void _selectPage(int index) {
    setState(() {
      _selectedPageInex = index;
    });
  }
  //  BOTTOM TAB related part **************************************

  @override
  Widget build(BuildContext context) {
    // i call this function to be sure that the page map is up to date. 
    // Was using initState() before and this wasn't working
    setBuildTimeState();
    print('Building Bottom Tabs Screen');
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        backgroundColor: _appBarBgColor,
        title: Text(_pages[_selectedPageInex]['title']),
        actions: <Widget>[
          SwitchTabs(
            switchTabsMode: widget.switchTabsMode,
            isBottomTabsDisplayed: widget.isBottomTabsDisplayed,
          ),
        ],
      ),
      body: _pages[_selectedPageInex]['widget'],
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        // permits to indicate which tab is currently selected
        currentIndex: _selectedPageInex,

        /// permits to add a nice little when switching tabs
        /// to change the backgroundColor, have to now define it
        ///  in each [BottomNavigationBarItem] and not in [BottomNavigationBar] anymore
        type: BottomNavigationBarType.shifting,

        // Caution: Flutter automatically gives an index to _selectPage method here
        // no need to give the index parameter by yourself
        /// onTap is required
        ///
        onTap: _selectPage,

        /// The list of Tabs, it's required
        ///
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(Icons.star),
            title: Text('Favorites'),
          )
        ],
      ),
    );
  }
}
