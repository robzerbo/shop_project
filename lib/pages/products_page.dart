import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_project/components/app_drawer.dart';
import 'package:shop_project/components/products_item.dart';
import 'package:shop_project/models/product_list.dart';
import 'package:shop_project/utils/app_routes.dart';

class ProducstPage extends StatelessWidget {
  const ProducstPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of<ProductList>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar produtos'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.product_form), 
            icon: Icon(Icons.add)
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsetsGeometry.all(8),
        child: ListView.builder(
          itemCount: products.itensCount,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ProductsItem(
                  product: products.itens[index],
                ),
                Divider()
              ],
            );
          },
        ),
      ),
    );
  }
}