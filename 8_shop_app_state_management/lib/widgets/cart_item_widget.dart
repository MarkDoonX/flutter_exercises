import 'package:flutter/material.dart';

import '../providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  final Cart cart;
  final int index;

  CartItemWidget(this.cart, this.index);

  @override
  Widget build(BuildContext context) {

    final String title = cart.getCartItemByIndex(index).title;
    final int quantity = cart.getCartItemByIndex(index).quantity;
    final double price = cart.getCartItemByIndex(index).price;

    return Card(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            child: SizedBox(
              height: 15,
              width: 50,
            ),
          ),
          Text(title, ),
          Text(price.toString()),
          IconButton(
            icon: Icon(Icons.remove_circle_outline),
            onPressed: () => cart.removeCartItem(
              cart.cartKeysList[index],
            ),
          ),
          Text(quantity.toString()),
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () => cart.addCartItem(
              cart.cartKeysList[index],
              title,
              price,
            ),
          ),
          Text((quantity * price).toString()),
        ],
      ),
    );
  }
}
