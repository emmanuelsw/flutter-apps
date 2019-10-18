import 'package:flutter/material.dart';
import 'package:meals/utils/style.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final Color color;

  const CategoryItem({Key key, this.title, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.5),
            color,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight
        ),
      ),
      child: Text(title, style: AppStyle.title),
    );
  }
}
