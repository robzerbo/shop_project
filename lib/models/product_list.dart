import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_project/data/dummy_data.dart';
import 'package:shop_project/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _itens = dummyProducts;

  List<Product> get itens => [..._itens];
  List<Product> get favoriteItens => _itens.where((produto)=>produto.isFavorite).toList();

  int get itensCount{
    return _itens.length;
  }

  void addProductFromData(Map<String, Object> data){
    bool hasId = data['id'] != null;

    final newProduct = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(), 
      name: data['name'] as String, 
      description: data['description'] as String, 
      price: double.parse(data['price'] as String), 
      imageUrl: data['imageUrl'] as String
    );

    if (hasId) {
      updtadeProduct(newProduct);
    }else{
      addProduct(newProduct);
    }
  }

  void addProduct(Product product){
    _itens.add(product);
    notifyListeners();
  }

  void updtadeProduct(Product product){
    int index = _itens.indexWhere((p) => p.id == product.id);

    if(index >= 0){
      _itens[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(Product product){
    int index = _itens.indexWhere((p) => p.id == product.id);

    if(index >= 0){
      _itens.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }
}