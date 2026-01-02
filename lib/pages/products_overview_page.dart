import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_project/components/app_drawer.dart';
import 'package:shop_project/components/badge_stack.dart';
import 'package:shop_project/components/product_grid.dart';
import 'package:shop_project/models/cart.dart';
import 'package:shop_project/utils/app_routes.dart';

enum FilterOptions{
  all,
  favorite
}

class ProductsOverviewPage extends StatefulWidget {
  
  const ProductsOverviewPage({super.key});

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoriteOnly = false;
  
  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Loja'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.filter_alt),
            itemBuilder: (_) => [
              PopupMenuItem(
                value: FilterOptions.favorite,
                child: Text('Somente Favoritos'),
              ),
              PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Todos'),
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if(selectedValue == FilterOptions.favorite){
                  _showFavoriteOnly = true;
                }else{
                  _showFavoriteOnly = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.cart);
                }, 
                icon: Icon(Icons.shopping_cart), 
              ),
            builder: (ctx, cart, child) => BadgeStack(
              value: cart.itensCount.toString(),
              child: child!,
            ),
          )
        ],
      ),
      body: ProductWidget(showFavoriteOnly: _showFavoriteOnly,),
      drawer: AppDrawer(),
    );
  }
}

