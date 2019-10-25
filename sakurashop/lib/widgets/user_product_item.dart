import 'package:flutter/material.dart';
import 'package:sakurashop/screens/product_form_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: Container(
          width: 96,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                color: Colors.indigo,
                onPressed: () {
                  Navigator.of(context).pushNamed(ProductFormScreen.route, arguments: id);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete_forever),
                color: Colors.pink[400],
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
