import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_project/models/product.dart';
import 'package:shop_project/models/product_list.dart';
import 'package:shop_project/utils/app_routes.dart';

class ProductsItem extends StatelessWidget {
  final Product product;

  const ProductsItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.product_form,
                  arguments: product
                );
              }, 
              icon: Icon(Icons.edit),
              color: Theme.of(context).colorScheme.primary,
              ),
            IconButton(
              onPressed: 
              () => showDialog<bool>(
                context: context, 
                builder: (context) {
                  return AlertDialog(
                    title: Text("Excluír Produto"),
                    content: Text("Você tem certeza que seja excluír o produto?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        }, 
                        child: Text('Sim')
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        }, 
                        child: Text('Não')
                      ),
                    ],
                  );
                }
              ).then((value) {
                if(context.mounted && (value ?? false)) Provider.of<ProductList>(context, listen: false).removeProduct(product);
              }), 
              icon: Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
              )
          ],
        ),
      ),
    );
  }
}