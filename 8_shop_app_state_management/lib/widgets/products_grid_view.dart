import 'package:flutter/material.dart';
// import this to use Provider() here
import 'package:provider/provider.dart';

import './product_item.dart';
import '../providers/products_provider.dart';

class ProductsGridView extends StatelessWidget {
  final bool isFavoritesToFilter;

  ProductsGridView({@required this.isFavoritesToFilter});

  @override
  Widget build(BuildContext context) {
    // We have to indicate the class of Provider we look for. Here [ProductsProvider]
    // the Provider listener in here will search into parent widgets until it finds a Provider Widget.
    // Then it will search for the Provider we have indicated:
    //    -> in our case, [ProductsProvider] is returned by the anonymous function in
    //    -> the builder parameter of [ChangeNotifierProvider] in main.dart
    //    -> main.dart being the direct parent for all the widgets that need to be informed
    //    -> about any change in the List of Products
    // Calling the .of(context) method will make this current widget re-build()
    final productsList = isFavoritesToFilter
        ? Provider.of<ProductsProvider>(context).favoriteItems
        : Provider.of<ProductsProvider>(context).items;

    // Using builder() permits to optimize longer GridViews
    // it only renders items that are on the screen and not the oes that are not
    // on the screen,  which also optimises performance
    return GridView.builder(
      // remember: using const for datas that dont move permits to skip them when
      // the widget rebuilds, which can save some performance
      padding: const EdgeInsets.all(10),
      itemCount: productsList.length,

      /// For each item in the list, we build a new [ProductItem] that we wrap into a
      /// [ChangeNotifierProvider] provider, which permits to pass a [Product] provider
      /// since [Product] uses the [ChangeNotifier] mixin!
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        // productsList[i] is of type Product, which mix-ins ChangeNotifier 
        value: productsList[i],
        child: ProductItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // this is the number of Columns
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
