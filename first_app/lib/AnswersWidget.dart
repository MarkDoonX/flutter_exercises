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

  // @required is given by meta.dart
  // to be able to use required named arguments, properties and functions must not be private
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
          // '() => _answerFunc(0)' ...This synthax works to use a function with arguments!
          // This works because a Lambda function actually is a pointer to an anonymous function!
          // This is a good example of how to use a sparate widget and give it variables AND functions
          // in parameters
          //
          // Now how to access a list of strings in the map?:
          // _questions[_questionsIndex]['answerText'][x] doesn't work for accessing a value in the string that's
          // corresponding to the 'answerText' Key because Dart CAN'T infer that this is actually a string; he takes
          // it as an objet (hoover over _questions shows the maps take strings as keys and objects as values)...
          // So we have to specify that the 'answerText' Key actually points to a List<String>. Now we can iterate
          // through it and access desired values using []

          // ------------------ //
          // AnswerButton((_questions[_questionsIndex]['answerText'] as List<String>)[0], () => _answerFunc(0)),
          // AnswerButton((_questions[_questionsIndex]['answerText'] as List<String>)[1], () => _answerFunc(1)),
          // AnswerButton((_questions[_questionsIndex]['answerText'] as List<String>)[2], () => _answerFunc(2)),
          // ------------------ //

          // Other Method which is not Hard-Coded
          // map method will apply the chosen method for each values (answer) we iterrate through in our List<String>
          // we can pass "answer" as an argument to that function.
          // we use the method ".toList()" because map returns an Iterable and not a list
          // the "..." is a spread operator: without it we would give  Column Widget a list of widgets, and not Widgets
          // "..." permits to pull out all the values of a list individually and give it to the surrounding List =>
          // here the surrounding List is Column
          ...(questions[questionsIndex]['answerText'] as List<String>)
              .map((answer) {
            return AnswerButton(
                answer,
                () => answerFunc(
                    (questions[questionsIndex]['answerText'] as List<String>)
                        .indexOf(answer)));
          }).toList(),
          RaisedButton(
            child: Text('Reset'),
            // this is an other exemple calling a function that takes parameters while onPressed param only can
            // be a void function with no params. In this case we use a named function insead of an anonymous
            // function. Both solutions return a pointer to a void function with no params.
            onPressed: testFunc,
          ),
        ],
      ),
    );
  }
}
