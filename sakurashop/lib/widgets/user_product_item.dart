import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../screens/product_form_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);

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
                onPressed: () async {
                  try {
                    await Provider.of<Products>(context, listen: false).deleteProduct(id);
                  } catch (e) {
                    scaffold.showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.pink[600],
                        content: Text('Deleting failed'),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
