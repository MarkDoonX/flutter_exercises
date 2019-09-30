import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/cart_screen.dart';

import '../widgets/products_grid_view.dart';
import '../widgets/badge.dart';

import '../providers/cart.dart';

enum FilterOptions {
  Favorites,
  All,
}

// I switch this widget to become a Stateful Widget because i need to handle the
// [isFavoritesToFilter] bool here. I handle it here and not in [ProductsProvider]
// because i only want to filter what's on THIS screen.
// We could manage [isFavoritesToFilter] in [ProductsProvider] if we wanted all the
// screens of our App to apply that filter though.
class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool isFavoritesToFilter = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            /// onSelected takes as argument the value of the [PopupMenuItem]
            /// we have selected.
            onSelected: (FilterOptions selectedValue) {
              // Important to do a setState here to rebuild the UI when we change the filter
              setState(() {
                if (selectedValue == FilterOptions.Favorites)
                  isFavoritesToFilter = true;
                else if (selectedValue == FilterOptions.All)
                  isFavoritesToFilter = false;
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Show only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              )
            ],
          ),
          // we define the child that is passed to the [Badge]'s child, in the child argument 
          // of the [Consumer].
          // the IconButton child is static and wont be rebuilt cause it's not in the builder
          // function
          Consumer<Cart>(
            builder: (_, cartData, ch) => Badge(
              child: ch,
              value: cartData.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () => Navigator.of(context).pushNamed(CartScreen.selfRoute),
            ),
          ),
        ],
      ),
      body: ProductsGridView(
        isFavoritesToFilter: isFavoritesToFilter,
      ),
    );
  }
}
