import 'package:flutter/material.dart';
import './screens/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sakura Shop',
      theme: ThemeData(
        canvasColor: Color.fromRGBO(241, 242, 246, 1),
        fontFamily: 'Quicksand'
      ),
      home: ProductsOverviewScreen(),
    );
  }
}