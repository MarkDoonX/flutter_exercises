import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String questionToDisplay;

  Question(this.questionToDisplay); 

  @override
  Widget build(BuildContext context) {
    return Container(
      // double.infinity means this Container will take as much space as it can take
      // now that the Container's width is larger than our Text, TextAlign.center will center the Text insided it
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
        // To make TextAlign.center center the Text widget based on screen's width, we have to put our text in a
        // container and give it the width of the screen. Text will then be centered inside that container...
        textAlign: TextAlign.center,
      ),
    );
  }
}
