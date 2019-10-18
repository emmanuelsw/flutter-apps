import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatelessWidget {
  final String id, title;

  const CategoryMealsScreen({Key key, this.id, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Text('The recipes for the category.'),
      ),
    );
  }
}
