import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime date;

  const OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.date,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    const url = 'https://sakura-shop.firebaseio.com/orders.json';
    try {
      final response = await http.get(url);
      final parsed = json.decode(response.body) as Map<String, dynamic>;
      if (parsed == null) {
        return;
      }
      final List<OrderItem> loadedOrders = [];
      parsed.forEach((id, data) {
        loadedOrders.add(
          OrderItem(
            id: id,
            amount: data['amount'],
            date: DateTime.parse(data['date']),
            products: (data['products'] as List<dynamic>)
                .map(
                  (item) => CartItem(
                    id: item['id'],
                    title: item['title'],
                    price: item['price'],
                    quantity: item['quantity'],
                  ),
                )
                .toList(),
          ),
        );
      });
      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addOrder(List<CartItem> products, double total) async {
    const url = 'https://sakura-shop.firebaseio.com/orders.json';
    final timestamp = DateTime.now();

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'amount': total,
          'products': products
              .map((product) => {
                    'id': product.id,
                    'title': product.title,
                    'quantity': product.quantity,
                    'price': product.price,
                  })
              .toList(),
          'date': timestamp.toIso8601String(),
        }),
      );
      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          products: products,
          date: timestamp,
        ),
      );
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
