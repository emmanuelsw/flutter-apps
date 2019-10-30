import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../ui/sakura_bar.dart';

class OrdersScreen extends StatelessWidget {
  static const route = '/orders';

  Widget _ordersBody(ordersData) {
    if (ordersData.orders.length > 0) {
      return ListView.builder(
        itemCount: ordersData.orders.length,
        itemBuilder: (ctx, i) => OrderItem(ordersData.orders[i]),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Card(
          elevation: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Text(
              'There are no orders to display.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: SakuraBar(
          title: 'Your Orders',
        ),
      ),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchOrders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.pink[400]),
              ),
            );
          } else {
            if (snapshot.error != null) {
              return Center(
                child: Text('Error'),
              );
            } else {
              return Consumer<Orders>(builder: (ctx, ordersData, child) => _ordersBody(ordersData));
            }
          }
        },
      ),
    );
  }
}
