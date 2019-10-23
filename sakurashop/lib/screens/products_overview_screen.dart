import 'package:flutter/material.dart';
import '../ui/SakuraBar.dart';
import '../widgets/products_grid.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: SakuraBar(
          title: 'Sakura Shop',
          actions: <Widget>[
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
      body: ProductsGrid(_showFavoriesOnly),
    );
  }
}
