import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../ui/sakura_bar.dart';

class CartScreen extends StatelessWidget {
  static const route = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: SakuraBar(
          title: 'Your Cart',
        ),
      ),
      body: Column(
        children: <Widget>[
          Card(
            elevation: 0,
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.indigo,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
