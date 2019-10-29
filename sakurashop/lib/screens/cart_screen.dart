import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';
import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
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
                    'Total:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 5),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.indigo,
                  ),
                  Spacer(),
                  OrderButton(cart: cart)
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              itemCount: cart.itemCount,
              itemBuilder: (ctx, i) => CartItem(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].title,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].price,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  final Cart cart;
  const OrderButton({@required this.cart});

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  Widget _buttonContent() {
    if (_isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.pink[400]),
        ),
      );
    } else {
      return Text(
        'Order Now',
        style: TextStyle(fontWeight: FontWeight.bold),
      );
    }
  }

  void _buttonAction() async {
    setState(() {
      _isLoading = true;
    });

    await Provider.of<Orders>(context, listen: false).addOrder(
      widget.cart.items.values.toList(),
      widget.cart.totalAmount,
    );
    setState(() {
      _isLoading = false;
    });
    widget.cart.clear();
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 0,
      disabledColor: Colors.grey[300],
      disabledTextColor: Colors.grey[700],
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading) ? null : _buttonAction,
      child: _buttonContent(),
    );
  }
}
