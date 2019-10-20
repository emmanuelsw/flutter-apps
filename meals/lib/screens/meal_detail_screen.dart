import 'package:flutter/material.dart';
import '../data/dummy-data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = 'meal-detail';

  Widget _sectionTitle(title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _listContainer({Widget child}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6),
      width: double.infinity,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final meal = DUMMY_MEALS.firstWhere((meal) => meal.id == id);

    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 243, 244, 1),
      appBar: AppBar(
        title: Text(
          '${meal.title}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _sectionTitle('Ingredients'),
            _listContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  for (var ingredient in meal.ingredients)
                    Card(
                      elevation: 0,
                      color: Colors.grey[300],
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Text(
                          ingredient,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            _sectionTitle('Steps'),
            _listContainer(
              child: Column(
                children: <Widget>[
                  for (MapEntry entry in meal.steps.asMap().entries)
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('${entry.key + 1}'),
                      ),
                      title: Text(
                        entry.value,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.delete),
        label: Text('Delete'),
        onPressed: () {
          Navigator.of(context).pop(id);
        },
      ),
    );
  }
}
