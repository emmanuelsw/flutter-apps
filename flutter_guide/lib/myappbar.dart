import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final Function resetQuiz;

  MyAppBar(this.resetQuiz);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      title: Text(
        'Quiz App', 
        style: TextStyle(fontFamily: 'Lie', fontSize: 22, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Color.fromRGBO(64, 64, 122, 1.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: resetQuiz,
        ),
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
      ],
    );
  }
}
