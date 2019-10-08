import 'package:flutter/material.dart';
import 'package:flutter_guide/question.dart';
import 'package:flutter_guide/answer.dart';

class Quiz extends StatelessWidget {
  final String question;
  final List<Map> answers;
  final Function answerQuestion;

  Quiz(this.question, this.answers, this.answerQuestion);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(question),
        for (var answer in answers) 
          Answer(() => answerQuestion(answer['score']), answer['text']),
      ],
    );
  }
}
