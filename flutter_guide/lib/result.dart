import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int score;
  final Function resetQuiz;

  Result(this.score, this.resetQuiz);

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
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 20),
            child: Text(
              phrase,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          RaisedButton(
            child: Text('Restart Quiz'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.lightBlue[300], width: 1.5)
            ),
            color: Colors.lightBlue[900],
            textColor: Colors.white,
            onPressed: resetQuiz,
          )
        ],
      ),
    );
  }
}
