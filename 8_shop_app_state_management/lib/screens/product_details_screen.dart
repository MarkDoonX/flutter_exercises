import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const selfRoute = '/product-details';

  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context).settings.arguments as String; // is the id!
    // We receipt the current up to date corresponding Product here!!
    // it's better to create the [findById()] function in the provider instead og having the logic here
    //
    // IMPORTANT: note the listen argument set to false!
    // it is true by default, which means that whenever we make a change in ProductsProvider and then
    // call the [notifyListeners()] method, we would rebuild this widget.
    // But, when we add a new Product to the the list and then call [notifyListeners()] for example
    // we dont need to rebuild this widget, since thes current Product's details didn't change!
    // Hence, since this widget doesn't need to rebuild after each modification in ProductsProvider
    // we set listen to false!!!
    final loadedProduct = Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: Center(
        child: Text(loadedProduct.description),
      ),
    );
  }
}
