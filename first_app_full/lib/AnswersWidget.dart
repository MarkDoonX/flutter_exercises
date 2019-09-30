import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import './QuestionWidget.dart';
import './AnswerButtonWidget.dart';

class Answers extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionsIndex;
  @required
  final void Function() testFunc;
  @required
  final void Function(int) answerFunc;

  Answers(
      {@required this.questions,
      @required this.questionsIndex,
      @required this.testFunc,
      @required this.answerFunc});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Question(
            questions[questionsIndex]['questionText'].toString(),
          ),
          ...(questions[questionsIndex]['answerText'] as List<Map<String, Object>>).map((answer) {
            return AnswerButton(answer['text'], () => answerFunc(answer['score']));
          }).toList(),
          RaisedButton(
            child: Text('Reset'),
            onPressed: testFunc,
          ),
        ],
      ),
    );
  }
}
