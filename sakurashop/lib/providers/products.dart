import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favorites {
    return _items.where((product) => product.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  Future<void> fetchProducts() async {
    const url = 'https://sakura-shop.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final parsed = json.decode(response.body) as Map<String, dynamic>;
      if (parsed == null) {
        return;
      }
      final List<Product> loadedProducts = [];
      parsed.forEach((id, data) {
        loadedProducts.add(
          Product(
            id: id,
            title: data['title'],
            description: data['description'],
            price: data['price'],
            imageUrl: data['imageUrl'],
            isFavorite: data['isFavorite'],
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://sakura-shop.firebaseio.com/products.json';

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite
        }),
      );

      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );

      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product product) async {
    final index = _items.indexWhere((product) => product.id == id);
    if (index >= 0) {
      final url = 'https://sakura-shop.firebaseio.com/products/$id.json';
      await http.patch(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
        }),
      );
      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = 'https://sakura-shop.firebaseio.com/products/$id.json';
    final index = _items.indexWhere((product) => product.id == id);
    var existingProduct = _items[index];

    _items.removeAt(index);

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(index, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }

    existingProduct = null;
    notifyListeners();
  }
}
