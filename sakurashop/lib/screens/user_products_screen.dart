import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../ui/sakura_bar.dart';
import '../screens/product_form_screen.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  static const route = '/user-products';

  Future<void> _refreshProducts(BuildContext ctx) async {
    await Provider.of<Products>(ctx).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: SakuraBar(
          title: 'Manage Products',
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(ProductFormScreen.route);
              },
            )
          ],
        ),
      ),
      body: RefreshIndicator(
        color: Colors.pink[400],
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: products.items.length,
            itemBuilder: (ctx, i) => UserProductItem(
              products.items[i].id,
              products.items[i].title,
              products.items[i].imageUrl,
            ),
          ),
        ),
      ),
    );
  }
}
