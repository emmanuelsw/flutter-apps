import 'package:flutter/material.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = 'meal-detail';

  const MealDetailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 243, 244, 1),
      appBar: AppBar(
        title: Text(
          id,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Text('Meal'),
      ),
    );
  }
}
