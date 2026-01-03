import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_project/models/cart.dart';
import 'package:shop_project/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  
  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      onDismissed: (_) {
        Provider.of<Cart>(
          context,
          listen: false,
        ).removeItem(cartItem.productId);
      },
      confirmDismiss: (_) => showDialog<bool>(
        context: context, 
        builder: (context) {
          return AlertDialog(
            title: Text("Você tem certeza?"),
            content: Text("Quer remover o item do carrinho?"),
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
        },
      ),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('${cartItem.price}'),
                ),
              ),
            ),
            title: Text(cartItem.name),
            subtitle: Text('Total: R\$ ${cartItem.price * cartItem.amount}'),
            trailing: Text('${cartItem.amount}x'),
          ),
        ),
      ),
    );
  }
}