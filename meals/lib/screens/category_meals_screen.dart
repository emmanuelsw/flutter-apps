import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../data/dummy-data.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = 'category-meals';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final id = routeArgs['id'];
    final title = routeArgs['title'];
    final meals = DUMMY_MEALS.where((meal) {
      return meal.categories.contains(id);
    }).toList();

    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 243, 244, 1),
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
          return MealItem(
            title: meals[i].title,
            imageUrl: meals[i].imageUrl,
            duration: meals[i].duration,
            complexity: meals[i].complexity,
            affordability: meals[i].affordability,
          );
        },
        itemCount: meals.length,
      ),
    );
  }
}
