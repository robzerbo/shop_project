import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_project/components/cart_item.dart';
import 'package:shop_project/models/cart.dart';
import 'package:shop_project/models/cart_item.dart';
import 'package:shop_project/models/order_list.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final List<CartItem> itens = cart.itens.values.toList();
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: ',
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  SizedBox(width: 10,),
                  Chip(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    label: Text(
                      'R\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.headlineLarge?.color
                      ),
                    )
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Provider.of<OrderList>(context, listen: false).addOrder(cart);
                      cart.clear();
                    }, 
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                        color: Theme.of(context).primaryColor
                      )
                    ),
                    child: Text('COMPRAR')
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: itens.length,
              itemBuilder: (ctx, i) {
                return CartItemWidget(cartItem: itens[i]);
              },
            ) 
          )
        ],
      ),
    );
  }
}