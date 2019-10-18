import 'package:flutter/material.dart';
import '../data/dummy-data.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = 'category-meals';

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
    final id = routeArgs['id'];
    final title = routeArgs['title'];
    final meals = DUMMY_MEALS.where((meal) {
      return meal.categories.contains(id);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) {
          return Text(meals[i].title);
        },
        itemCount: meals.length,
      ),
    );
  }

}
