import 'package:flutter/material.dart';

class CartItem {
  String id;
  String title;
  double price;
  int quantity;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.quantity,
  });
}

class Cart with ChangeNotifier {
  // The String key is the Id of the product we want to add to the cart
  Map<String, CartItem> _cartItemsMap = {};

  Map<String, CartItem> get cartItemsMap {
    return {..._cartItemsMap};
  }

  int get itemCount {
    return _cartItemsMap.length;
  }

  List<String> get cartKeysList {
    return _cartItemsMap.keys.toList();
  }

  /// Adds a [CartItem] to [_cartItemsMap] if the corresponding Product's [CartItem]
  /// is not already in the [_cartItemsMap]. Else, it update the [CartItem]'s quantity
  /// if it was already added to the [_cartItemsMap]
  void addCartItem(
    String productId,
    String title,
    double price,
  ) {
    if (_cartItemsMap.containsKey(productId)) {
      // increase quantity of this [CartItem] by 1
      _cartItemsMap.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: (existingCartItem.quantity + 1),
        ),
      );
    } else {
      // add a new [CartItem]
      _cartItemsMap.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeCartItem(String productId) {
    if (_cartItemsMap[productId].quantity > 1) {
      _cartItemsMap.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: (existingCartItem.quantity - 1),
        ),
      );
    }
    else if (_cartItemsMap[productId].quantity <= 1)  {
      _cartItemsMap.remove(productId);
    }
    notifyListeners();
  }

  // void deleteCartItem(){
  //   _cartItemsMap.remove(productId);
  // }

  CartItem getCartItemByIndex(int i) {
    return _cartItemsMap[cartKeysList[i]];
  }

  void printCartMap() {
    print("--------------------------------------");
    _cartItemsMap.forEach((id, cartItem) {
      print(
          "productId: $id, title: ${cartItem.title}, count: ${cartItem.quantity}");
    });
  }
}
