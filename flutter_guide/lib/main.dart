import 'package:flutter/material.dart';
import 'package:flutter_guide/quiz.dart';
import 'package:flutter_guide/result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _index = 0;
  var _score = 0;

  final _questions = const [
    {
      'question': '¿What\'s your favorite color?',
      'answers': [
        {'text': 'Black', 'score': 10 }, 
        {'text': 'Red', 'score': 3 }, 
        {'text': 'Blue', 'score': 2 }, 
        {'text': 'Pink', 'score': 1 }
      ],
    },
    {
      'question': '¿What\'s your favorite animal?',
      'answers': [
        {'text': 'Dog', 'score': 10 }, 
        {'text': 'Cat', 'score': 10 }, 
        {'text': 'Rabbit', 'score': 2 }, 
        {'text': 'Snake', 'score': 5 }, 
        {'text': 'Lion', 'score': 6 }
      ],
    },
    {
      'question': '¿Who\'s your favorite teacher?',
      'answers': [
        {'text': 'Mori-sensei', 'score': 5 }, 
        {'text': 'Mori-sensei', 'score': 5 },
        {'text': 'Mori-sensei', 'score': 5 },
        {'text': 'Random', 'score': 2 }
      ],
    }
  ];

  void _answerQuestion(int score) {
    _score += score;
    setState(() {
      _index++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _index = 0;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Quiz App'),
          backgroundColor: Colors.lightBlue[900],
        ),
        body: _index < _questions.length
          ? Quiz(
              _questions[_index]['question'], 
              _questions[_index]['answers'],
              _answerQuestion
            )
          : Result(_score, _resetQuiz),
      ),
    );
  }
}
