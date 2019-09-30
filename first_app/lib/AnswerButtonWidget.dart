import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final String _answer;

  // void Function() is indeed the type of __answerFuncPointer (which is a pointer to a void function)
  // to find this type => go to definition of "onPressed" =>  go to definition of "VoidCallback"
  // we can see: "typedef VoidCallback = void Function();" , which means that we define VoidCallback
  // as a void Function() type
  @required
  final void Function() __answerFunc;

  AnswerButton(this._answer, this.__answerFunc);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      width: double.infinity,
      child: RaisedButton(
        color: Colors.amber,
        child: Text(
          _answer,
          style: TextStyle(
            fontSize: 40,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: __answerFunc,
      ),
    );
  }
}
