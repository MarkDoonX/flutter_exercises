import 'package:flutter/material.dart';

class QuizzDone extends StatelessWidget {
  @required
  final void Function() testFunc;
  final int totalScore;

  QuizzDone(this.testFunc, this.totalScore);

  String get resultQuizz {
    String resultText;
    if (totalScore <= 7)
      resultText = "You are an Amazing person!";
    else if (totalScore <= 12)
      resultText = "You are a good person!";
    else if (totalScore <= 20)
      resultText = "Hmmm, you are a bit mean, but we can handle that!";
    else if (totalScore <= 30)
      resultText = "You are so bad..really... so bad...";
    else
      resultText = "You are Evil, everyone should flee when they see you!";
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              resultQuizz,
              style: TextStyle(
                fontSize: 50,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          FlatButton(
            child: Text('Reset'),
            onPressed: testFunc,
          ),
        ],
      ),
    );
  }
}
