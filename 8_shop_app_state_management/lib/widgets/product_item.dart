import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_details_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Listening to the current instance of Product
    // It's because of this that the widget is re-build() when [Product] state changes
    //
    // To test the [notifyListeners()] method, we can set listen to false here!
    // if we do that, when we click on the Favorite Icon, we would actualy change the value,
    // in Product, but not re-build() the widget as it should be !!!
    // final product = Provider.of<Product>(context, listen: false);
    //
    // now i actually will use Consumer, which permits to micro-manage which widgets to rebuild
    // so i'll keep product, but set Listen to fales, to to able to use the data but not rebuild
    // the whole widget, as only the Favorite Button needs to re-build here
    // have to take this into account for gains in performance
    final product = Provider.of<Product>(context, listen: false);
    // as a proof, check the print below !! it doesn't print when we press the Favorite Button !!!
    print('Building ProductItem ${product.id}');
    // here i get acces to the nearest provided Cart
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () => Navigator.of(context)
            .pushNamed(ProductDetailsScreen.selfRoute, arguments: product.id),

        /// [GridTile] can be used anywhere but fit particularly well in a GridView
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            // chose a fit option for the image
            fit: BoxFit.cover,
          ),

          /// [GridTileBar] fits well to draw [GridTile] header or footer
          footer: GridTileBar(
            backgroundColor: Colors.black87,

            /// Using [Consumer<Product>] here, works in the end like [Provider.of<Product>]
            /// But the advantage is that is permits to micro-manage which widget to re-build
            /// inside a bigger widget tree that we dont necessarly want to split separate files
            /// the child: parameter actually permits to set a widget that wont rebuild when the
            /// Listener is triggered! and wethen can use thsi child as an argument to pass to our builder
            /// and use when we need!
            ///
            /// FAVORITE BUTTON
            leading: Consumer<Product>(
              builder: (ctx, prod, _) => IconButton(
                icon: prod.isFavorite
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border),

                /// When we call [toggleFavoriteState()] method, we update the current Product
                /// and we then call [notifyListeners()]. Since we Listen to [Product] state, we
                /// then re-build() this widget, which updates the favorite icon
                onPressed: () => product.toggleFavoriteState(),
                color: Theme.of(context).accentColor,
              ),
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),

            /// CART BUTTON
            trailing: IconButton(
              icon: Icon(Icons.add_shopping_cart),
              splashColor: Colors.red,
              onPressed: () {
                cart.addCartItem(product.id, product.title, product.price);
                cart.printCartMap();
              },
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
