import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = 'category-meals';
  final List<Meal> availableMeals;

  const CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String title;
  List<Meal> meals;
  var _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
      final id = routeArgs['id'];
      title = routeArgs['title'];
      meals = widget.availableMeals.where((meal) {
        return meal.categories.contains(id);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  } 

  void _removeMeal(id) {
    setState(() {
      meals.removeWhere((meal) => meal.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
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
            id: meals[i].id,
            title: meals[i].title,
            imageUrl: meals[i].imageUrl,
            duration: meals[i].duration,
            complexity: meals[i].complexity,
            affordability: meals[i].affordability,
            removeItem: _removeMeal,
          );
        },
        itemCount: meals.length,
      ),
    );
  }
}
