import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_project/models/cart.dart';
import 'package:shop_project/models/product.dart';
import 'package:shop_project/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  
  
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(
      context,
      listen: true
    );
    final Cart cart = Provider.of<Cart>(
      context,
      listen: false
    );
    
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(10),
      child: GridTile(
        footer: GridTileBar(
          title: Text(
            product.name,
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            onPressed: () {
              product.togggleFavorite();
            }, 
            icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
            color: Theme.of(context).colorScheme.secondary,
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(product);
            }, 
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.secondary,
          ),
          backgroundColor: Colors.black87,
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.productDetais,
              arguments: product
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
            ),
        ),
      ),
    );
  }
}