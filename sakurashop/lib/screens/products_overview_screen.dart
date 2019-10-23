import 'package:flutter/material.dart';
import '../ui/SakuraBar.dart';
import '../widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: SakuraBar(
          title: 'Sakura Shop',
        ),
      ),
      body: ProductsGrid(),
    );
    return scaffold;
  }
}