import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList extends ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}

// Exemplo na utilização de provider de modo global para ação de favorito!
// final List<Product> _items = dummyProducts;
//   bool _showFavoriteOnly = false;

//   List<Product> get items {
//     if (_showFavoriteOnly) {
//       return   
//     }
//     return [..._items];
//   }

//   showFavoriteOnly() {
//     _showFavoriteOnly = true;
//     notifyListeners();
//   }

//   showAll() {
//     _showFavoriteOnly = false;
//     notifyListeners();
//   }