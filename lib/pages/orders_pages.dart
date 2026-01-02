import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_project/components/app_drawer.dart';
import 'package:shop_project/components/order.dart';
import 'package:shop_project/models/order_list.dart';

class OrdersPages extends StatelessWidget {
  const OrdersPages({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of<OrderList>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pedidos'),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orders.itensCount,
        itemBuilder: (ctx, i) {
          return OrderWidget(order: orders.itens[i]);
        }
      ),
    );
  }
}