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
  var _isLoading = false;

  @override
  void initState() {
    _isLoading = true;
    Provider.of<Products>(context, listen: false).fetchProducts().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
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
              onSelected: (FilterOptions selected) {
                setState(() {
                  if (selected == FilterOptions.Favorites) {
                    _showFavoriesOnly = true;
                  } else {
                    _showFavoriesOnly = false;
                  }
                });
              },
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
            ),
          ],
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.pink[400]),
              ),
            )
          : ProductsGrid(_showFavoriesOnly),
    );
  }
}
