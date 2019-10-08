import 'package:flutter/material.dart';
import 'package:flutter_guide/question.dart';
import 'package:flutter_guide/answer.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var index = 0;

  var questions = [
    {
      'question': '¿What\'s your favorite color?',
      'answers': ['Black', 'Red', 'Blue', 'Pink'],
    },
    {
      'question': '¿What\'s your favorite animal?',
      'answers': ['Dog', 'Cat', 'Rabbit', 'Snake', 'Lion'],
    },
    {
      'question': '¿Who\'s your favorite teacher?',
      'answers': ['Mori-sensei', 'Mori-sensei', 'Mori-sensei'],
    }
  ];

  void _answerQuestion() {
    setState(() {
      index++;
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
          backgroundColor: Colors.lightBlue[900],
        ),
        body: Column(
          children: [
            Question(questions[index]['question']),
            for (var answer in questions[index]['answers'])
              Answer(_answerQuestion, answer),
          ],
        ),
      ),
    );
  }
}
