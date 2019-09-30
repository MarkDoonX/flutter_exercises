// permits to use @required
import 'package:flutter/foundation.dart';

/// Product used to be a simple model but i converted it into a provider
/// so that widgets can Listen and rebuild when an individual product
/// changes his [isFavorite] state!
class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({    
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavoriteState() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
