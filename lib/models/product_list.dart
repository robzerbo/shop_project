import 'package:flutter/material.dart';
import 'package:shop_project/data/dummy_data.dart';
import 'package:shop_project/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _itens = dummyProducts;

  List<Product> get itens => [..._itens];
  List<Product> get favoriteItens => _itens.where((produto)=>produto.isFavorite).toList();

  void addProduct(Product product){
    _itens.add(product);
    notifyListeners();
  }
}