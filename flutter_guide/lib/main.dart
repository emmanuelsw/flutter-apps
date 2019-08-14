import 'package:flutter/material.dart';
import 'package:flutter_guide/question.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  final List quesitons = [
    '¿What\'s your favorite color?',
    '¿What\'s your favorite animal?',
  ];

  void _answerQuestion() {
    setState(() {
      _questionIndex++;
    });
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Question(quesitons[_questionIndex]),
            RaisedButton(
              onPressed: _answerQuestion,
              child: Text('Aswer 1'),
            ),
            RaisedButton(
              onPressed: _answerQuestion,
              child: Text('Aswer 2'),
            ),
            RaisedButton(
              onPressed: _answerQuestion,
              child: Text('Aswer 3'),
            ),
          ],
        ),
      )
    );
  }

}