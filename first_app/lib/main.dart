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
  //VARIABLES AND FUNCTIONS
  final List<Map<String, Object>> _questions = const [
    // Curly Brackets are used to define a Map (Key/Value pair List)
    {
      'questionText': 'What\'s your favorite color?',
      'answerText': ['Red', 'Blue', 'Yellow', 'green'],
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answerText': ['Cat', 'Dog', 'Bird'],
    },
    {
      'questionText': 'What\'s your favorite country?',
      'answerText': ['France', 'England', 'Spain', 'UK', 'Australia'],
    },
    {
      'questionText': 'What\'s your favorite food?',
      'answerText': ['Pastas', 'Steak', 'Spinach'],
    },
    {
      'questionText': 'Are you satified of this Quizz?',
      'answerText': ['Yes', 'No'],
    },
  ];

  var _questionsIndex = 0;

  void _answerFunc(int answerIndex) {
    if (_questionsIndex == (_questions.length - 1)) {
      print('Question n°${_questionsIndex + 1}. Answer is: ' +
          '${(_questions[_questionsIndex]['answerText'] as List<String>)[answerIndex]}\n' +
          'Quizz is done!');
      setState(() {
        _questionsIndex += 1;
      });
    } else {
      setState(() {
        _questionsIndex += 1;
      });
      print('Question n°$_questionsIndex. Answer is: '
          '${(_questions[_questionsIndex - 1]['answerText'] as List<String>)[answerIndex]} ');
    }
  }

  void _testFunc() {
    _resetQuestions('The questions have been reset!');
  }

  void _resetQuestions(String msg) {
    setState(() {
      _questionsIndex = 0;
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
        // body renders from a ternary expression => depending on State, we will render one widget or an other
        body: (_questionsIndex < _questions.length)
            ? Answers(
                answerFunc: _answerFunc,
                questions: _questions,
                questionsIndex: _questionsIndex,
                testFunc: _testFunc,
              )
            : QuizzDone(_testFunc),
      ),
    );
  }
}
