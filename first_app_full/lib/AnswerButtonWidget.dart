import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final String answer;
  @required
  final void Function() answerFunc;

  AnswerButton(this.answer, this.answerFunc);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      width: double.infinity,
      child: RaisedButton(
        color: Colors.amber,
        child: Text(
          answer,
          style: TextStyle(
            fontSize: 40,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: answerFunc,
      ),
    );
  }
}
