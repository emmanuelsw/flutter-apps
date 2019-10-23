import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        header: IconButton(
          icon: Icon(
            product.isFavorite ? Icons.favorite : Icons.favorite_border,
          ),
          alignment: Alignment.topLeft,
          color: Colors.pink[700],
          onPressed: () {
            product.toggleFavorite();
          },
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.route,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            product.title,
            textAlign: TextAlign.left,
          ),
          trailing: IconButton(
            iconSize: 20,
            icon: Icon(Icons.add_shopping_cart),
            color: Colors.indigo[300],
            onPressed: () {
              cart.addItem(product.id, product.title, product.price);
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 2),
                  backgroundColor: Colors.green,
                  content: Text("${product.title} added to the cart!"),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
