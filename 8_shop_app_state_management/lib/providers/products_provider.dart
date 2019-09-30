import 'package:flutter/material.dart';

import './product.dart';
/// This Provider permits to inform all Listening widgets whenever
/// a modification is made in the [List<Product>], so whenever we add
/// or remove a Product from the list
/// 
/// Using with keyword is called a [mixin].
/// It permits to inherit some methods/properties from an other class
/// without extending that class
/// The [ChangeNotifier] class uses [InheritedWidget] behind the sceens
/// it exposes a method that permits to inform listeners about any change of data here
class ProductsProvider with ChangeNotifier {
  // _items is private cause of the "_"
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  // Since _items is private, we have to create a getter to access it outside
  // of this class.
  // Important notes:
  //    - We do NOT return _items directly, because if we did that, we would actually
  //      return a POINTER to _items. Which means anyone that would get _items, would
  //      then be able to directly modify it in this class
  //    - Instead, we want to provide a copy of _items, which will permit to know its
  //      current state, but no to modify it.
  //      --> that's why we return [..._items]: the "..." permits to exctract each item
  //          in the list, and [] to make a list of exctracted items.
  //      --> [.._items] is then a simple copy of _items and that's what we provide
  List<Product> get items {
    // return _items;
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite == true).toList();
  }

  // We will use this method to add a new product into the _items list
  // Then how to inform the widgets that use this data that it has changed,
  // and then rebuild?
  // Fotr that we use the notifyListeners() method that is provided by ChangeNotidier class
  void addProduct() {
    // _items.add(product);
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }
}
