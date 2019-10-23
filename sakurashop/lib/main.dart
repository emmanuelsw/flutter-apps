import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/cart_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';

import './providers/cart.dart';
import './providers/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sakura Shop',
        theme: ThemeData(
          canvasColor: Color.fromRGBO(241, 242, 246, 1),
          fontFamily: 'Quicksand',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.route: (ctx) => ProductDetailScreen(),
          CartScreen.route: (ctx) => CartScreen(),
        },
      ),
    );
  }
}
