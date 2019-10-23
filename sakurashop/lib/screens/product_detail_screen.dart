import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../ui/SakuraBar.dart';

class ProductDetailScreen extends StatelessWidget {
  static const route = '/product-detail';

  const ProductDetailScreen({Key key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final product = Provider.of<Products>(context, listen: false).findById(id);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: SakuraBar(
          title: product.title,
        ),
      ),
    );
  }
}
