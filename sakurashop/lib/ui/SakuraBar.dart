import 'package:flutter/material.dart';

class SakuraBar extends StatelessWidget {
  final String title;
  final List actions;

  const SakuraBar({Key key, @required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      brightness: Brightness.light,
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.pink[400],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
