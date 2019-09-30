import 'package:flutter/material.dart';

import '../widgets/cart_items_list.dart';

class CartScreen extends StatelessWidget {
  static const selfRoute = '/cart-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: CartItemsList(),
    );
  }
}
