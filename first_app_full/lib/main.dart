// **********************************************************************************************************
// first_app_full is different from first_app, because it's closer to the course's functionnalities.
// The main differences are:
//  - in first_app, _questions doesn't have a map as "answerText".
//  - in first_app, _answerFunc writes stuff in the console and it is a function that takes arguments
//    hence it changes the way to pass it around.
//  - most of the comments that help learning are in first_app. Since they are different in
//    first_app_full, i have deleted them.
//  - the function that resets the Quizz is different
// It is important to check first_app to see these specificities and understand how first_app_full works.
// first_app works perfectly by itself.
// **********************************************************************************************************

import 'package:flutter/material.dart';

import './AnswersWidget.dart';
import './QuizzDoneWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // personality test. Higher Score = more dangerous personality
  final List<Map<String, Object>> _questions = const [
    {
      'questionText': 'What\'s your favorite color?',
      'answerText': [
        {'text': 'Red', 'score': 6},
        {'text': 'Blue', 'score': 2},
        {'text': 'Black', 'score': 10},
        {'text': 'Yellow', 'score': 4},
        {'text': 'Green', 'score': 1}
      ],
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answerText': [
        {'text': 'Cat', 'score': 9},
        {'text': 'Dog', 'score': 5},
        {'text': 'Bird', 'score': 2}
      ],
    },
    {
      'questionText': 'What\'s your favorite food?',
      'answerText': [
        {'text': 'Pastas', 'score': 5},
        {'text': 'Steak', 'score': 10},
        {'text': 'Spinach', 'score': 1}
      ],
    },
    {
      'questionText': 'Are you satified of this Quizz?',
      'answerText': [
        {'text': 'Yes', 'score': 1},
        {'text': 'No', 'score': 5}
      ],
    },
  ];

  var _questionsIndex = 0;
  var _totalScore = 0;

  void _answerFunc(int score) {
    setState(() {
      _questionsIndex += 1;
      _totalScore += score;
    });
  }

  void _testFunc() {
    _resetQuestions('The questions have been reset!');
  }

  void _resetQuestions(String msg) {
    setState(() {
      _questionsIndex = 0;
      _totalScore = 0;
    });
    print(msg);
  }

  // WIDGET BUILDING
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('My First App 2!'),
        ),
        body: (_questionsIndex < _questions.length)
            ? Answers(
                answerFunc: _answerFunc,
                questions: _questions,
                questionsIndex: _questionsIndex,
                testFunc: _testFunc,
              )
            : QuizzDone(_testFunc, _totalScore),
      ),
    );
  }
}
