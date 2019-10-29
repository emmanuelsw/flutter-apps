import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite() async {
    final url = 'https://sakura-shop.firebaseio.com/products/$id.json';
    var oldStatus = isFavorite;

    isFavorite = !isFavorite;
    notifyListeners();

    try {
      await http.patch(
        url,
        body: json.encode({
          'isFavorite': isFavorite,
        }),
      );
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
      throw error;
    }
  }
}
