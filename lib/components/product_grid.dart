import 'package:flutter/material.dart';
import 'package:shop_project/models/product.dart';
import 'package:provider/provider.dart';
import 'package:shop_project/components/product_item.dart';
import 'package:shop_project/models/product_list.dart';

class ProductWidget extends StatelessWidget {
  
  final bool showFavoriteOnly; 
  
  const ProductWidget({
    super.key,
    required this.showFavoriteOnly
  });

  @override
  Widget build(BuildContext context) {

    final List<Product> loadedProducts = showFavoriteOnly ?
    Provider.of<ProductList>(context).favoriteItens
    :
    Provider.of<ProductList>(context).itens;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3/2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10
      ), 
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: loadedProducts[i],
        child: ProductItem()
      ),
      itemCount: loadedProducts.length,
      padding: EdgeInsets.all(10),
    );
  }
}