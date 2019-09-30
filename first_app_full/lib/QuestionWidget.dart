import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String questionToDisplay;

  Question(this.questionToDisplay);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 10, color: Colors.redAccent),
          right: BorderSide(width: 10, color: Colors.pinkAccent),
          bottom: BorderSide(width: 10, color: Colors.orangeAccent),
          left: BorderSide(width: 10, color: Colors.purpleAccent),
        ),
      ),
      child: Text(
        questionToDisplay,
        style: TextStyle(
          color: Colors.blueGrey,
          fontSize: 30,
          backgroundColor: Colors.limeAccent,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
