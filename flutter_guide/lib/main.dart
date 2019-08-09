import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  var questionIndex = 0;
  final List quesitons = [
    '¿What\'s your favorite color?',
    '¿What\'s your favorite animal?',
  ];

  void answerQuestion() {
    questionIndex++;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Jewel App'),
          backgroundColor: Colors.lightBlue[900]
        ),
        body: Column(
          children: [
            Text(quesitons[questionIndex]),
            RaisedButton(
              onPressed: answerQuestion,
              child: Text('Aswer 1'),
            ),
            RaisedButton(
              onPressed: answerQuestion,
              child: Text('Aswer 2'),
            ),
            RaisedButton(
              onPressed: answerQuestion,
              child: Text('Aswer 3'),
            ),
          ],
        ),
      )
    );
  }

}