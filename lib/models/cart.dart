import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_project/models/cart_item.dart';
import 'package:shop_project/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _itens = {};

  Map<String, CartItem> get itens{
    return {..._itens};
  }

  int get itensCount{
    return _itens.length;
  }

  double get totalAmount{
    double total = 0.0;
    _itens.forEach((key, cartItem) {
      total += cartItem.price * cartItem.amount;
    });
    return total;
  }

  void addItem(Product product){
    if(_itens.containsKey(product.id)){
      _itens.update(product.id, (existingItem) => CartItem(
        id: existingItem.id, 
        productId: existingItem.productId, 
        name: existingItem.name, 
        amount: existingItem.amount + 1, 
        price: existingItem.price
      ));
    }else{
      _itens.putIfAbsent(
        product.id, 
        () => CartItem(
        id: Random().nextDouble().toString(), 
        productId: product.id, 
        name: product.name, 
        amount: 1, 
        price: product.price
      ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId){
    _itens.remove(productId);
    notifyListeners();
  }

  void clear(){
    _itens = {};
    notifyListeners();
  }
}