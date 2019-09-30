import 'package:flutter/material.dart';

class QuizzDone extends StatelessWidget {
  @required
  final void Function() _testFunc;

  QuizzDone(this._testFunc);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              'Quizz is done!',
              style: TextStyle(fontSize: 50),
            ),
          ),
          RaisedButton(
            child: Text('Reset'),
            onPressed: _testFunc,
          ),
        ],
      ),
    );
  }
}
