import 'package:flutter/material.dart';
// import this to be able to use providers
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import './screens/product_details_screen.dart';
import './screens/cart_screen.dart';
// importing a provider i made that holds the current state of
// the list of products
import './providers/products_provider.dart';
import './providers/cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // We wrap [MaterialApp] into [ChangeNotifierProvider] to be able to use providers
    // its builder parameter needs to take a function that returns a Provider created
    // by mixing in the ChangeNotifier class
    // here it provides an instance of ProductsProvider to all the children
    // Though MaterialApp wont be rebuilt anytime data changes in our Provider!!!
    // Instead, we will set a Listener in the child widgets that actually need that data!
    // for exemple in ProductsGridView
    //
    // [ChangeNotifierProvider] only works with objects based on classes that use the
    // [ChangeNotifier] mixin. And this is the most common use-case, because you
    // typically want to be your global data changeable (and have the app UI react to that).
    // but it's possible to provide more simple data like a string:
    // -> ex: Provider<String>(builder: (ctx) => 'Hello', child: ...)
    // -> this can be used when manipulating const values.
    //
    // Modif: i use .value because we dont need to use the context here
    // old version:
    //      -->   return ChangeNotifierProvider(
    //      -->     builder: (ctx) => ProductsProvider(),
    //
    // also .value is a must use in cases we provide data toa list or grid, because if we use the builder
    // instead, we then wouldn't update the data in cases where where the widget re-builds after an
    // other value, not handled by this provider is modified!!!
    //
    // Important note: [ChangeNotifierProvider] automatically cleans up the old data when it's obsolete
    // (when we navigate to a totally diferent widget for example).
    // But this is very important to keep in mind since if this wasn't doing it, it would lead to memory
    // leaks and would would be hard to know where it comes from
    //
    // [MultiProvider] permits to setup multiple providers to the same unique child
    // it's cleaner than nesting providers by creating unnecessary widget
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProductsProvider(),),
        ChangeNotifierProvider.value(value: Cart(),),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          // is not restarted.
          primarySwatch: Colors.amber,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailsScreen.selfRoute: (ctx) => ProductDetailsScreen(), // '/product-details'
          CartScreen.selfRoute: (ctx) => CartScreen(), // '/cart-screen'
        },
      ),
    );
  }
}
