import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals/utils/style.dart';
import './category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id, title;
  final Color color;

  const CategoryItem({Key key, this.id, this.title, this.color})
      : super(key: key);

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).push(CupertinoPageRoute(
      builder: (_) {
        return CategoryMealsScreen(id: id, title: title);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.6),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(title, style: AppStyle.title),
      ),
    );
  }
}
