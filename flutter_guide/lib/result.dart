import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int score;

  Result(this.score);

  String get phrase {
    String text;
    if (score <= 8) {
      text = 'You are a bad person!';
    } else if (score <= 12) {
      text = 'You are a good person!';
    } else if (score <= 16) {
      text = 'You are awesome!';
    } else {
      text = 'You are a kitsune fukei!';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        phrase,
        style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold,),
        textAlign: TextAlign.center,
      ),
    );
  }
}