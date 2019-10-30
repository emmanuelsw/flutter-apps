import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/products.dart';
import '../ui/sakura_bar.dart';
import '../widgets/app_drawer.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';
import './cart_screen.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavoriesOnly = false;
  Future _fetchProducts;

  @override
  void initState() {
    _fetchProducts = Provider.of<Products>(context, listen: false).fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: SakuraBar(
          title: 'Sakura Shop',
          actions: <Widget>[
            Consumer<Cart>(
              builder: (_, cart, wchild) => Badge(
                child: wchild,
                value: cart.itemCount.toString(),
                color: Colors.indigo,
              ),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.route);
                },
              ),
            ),
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text('Only Favorites'),
                  value: FilterOptions.Favorites,
                ),
                PopupMenuItem(
                  child: Text('Show All'),
                  value: FilterOptions.All,
                ),
              ],
              onSelected: (FilterOptions selected) {
                setState(() {
                  if (selected == FilterOptions.Favorites) {
                    _showFavoriesOnly = true;
                  } else {
                    _showFavoriesOnly = false;
                  }
                });
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: _fetchProducts,
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
              return ProductsGrid(_showFavoriesOnly);
            }
          }
        },
      ),
    );
  }
}
