import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../widgets/cart_item_widget.dart';


class CartItemsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // CartScreen is a child of MyApp widget, so it can find [Cart]
    Cart cart = Provider.of<Cart>(context);

    return ListView.builder(
        itemBuilder: (ctx, i) {
          return CartItemWidget(cart, i);
        }, 
        itemCount: cart.itemCount,
    );
  }
}