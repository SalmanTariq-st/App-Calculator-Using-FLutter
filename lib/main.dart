// ignore_for_file: prefer_const_constructors, unused_element, unused_local_variable, avoid_unnecessary_containers, avoid_print, unused_import, depend_on_referenced_packages, prefer_is_empty

import 'dart:math';
import 'package:flutter/services.dart';
// import 'package:vibrate/vibrate.dart';
import 'package:calculator/button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  var userQuestion = '';
  var userAnswer = '';
  bool ansPressed = false;
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    'X',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'Ans',
    '='
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 41, 41, 41),
        body: Column(children: [
          Expanded(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        userQuestion,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,

                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        ansPressed ? userAnswer : '',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                color: Color.fromARGB(255, 32, 32, 32),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemCount: buttons.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return button(
                          buttonTapped: () {
                            HapticFeedback.vibrate();

                            setState(() {
                              userQuestion = '';
                              ansPressed = false;
                            });
                          },
                          color: Color.fromARGB(255, 15, 121, 20),
                          textColor: Colors.white,
                          text: buttons[index]);
                    } else if (index == 1) {
                      return button(
                          buttonTapped: () {
                            HapticFeedback.vibrate();

                            setState(() {
                              if (userQuestion.length > 0) {
                                userQuestion = userQuestion.substring(
                                    0, userQuestion.length - 1);
                              }
                              ansPressed = false;
                            });
                          },
                          color: Color.fromARGB(255, 159, 34, 25),
                          textColor: Colors.white,
                          text: buttons[index]);
                    } else if (index == buttons.length - 1) {
                      return button(
                          buttonTapped: () {
                            HapticFeedback.vibrate();

                            setState(() {
                              findAns();
                              ansPressed = false;
                            });
                          },
                          color: isOperator(buttons[index])
                              ? Color.fromARGB(255, 96, 94, 94)
                              : Color.fromARGB(255, 61, 61, 61),
                          textColor: Colors.white,
                          text: buttons[index]);
                    } else if (index == buttons.length - 2) {
                      return button(
                          buttonTapped: () {
                            HapticFeedback.vibrate();

                            setState(() {
                              if (ansPressed == true) {
                                ansPressed == false;
                              } else {
                                ansPressed = true;
                              }
                              userQuestion = '';
                            });
                          },
                          color: isOperator(buttons[index])
                              ? Color.fromARGB(255, 96, 94, 94)
                              : Color.fromARGB(255, 61, 61, 61),
                          textColor: Colors.white,
                          text: buttons[index]);
                    } else {
                      return button(
                          buttonTapped: () {
                            HapticFeedback.vibrate();

                            setState(() {
                              userQuestion = userQuestion + buttons[index];
                              ansPressed = false;
                            });
                          },
                          color: isOperator(buttons[index])
                              ? Color.fromARGB(255, 96, 94, 94)
                              : Color.fromARGB(255, 61, 61, 61),
                          textColor: Colors.white,
                          text: buttons[index]);
                    }
                  },
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  // ignore: dead_code
  bool isOperator(String val) {
    if (val == '+' ||
        val == '-' ||
        val == 'X' ||
        val == '/' ||
        val == '=' ||
        val == '%') {
      return true;
    }
    return false;
  }

  void findAns() {
    if (userQuestion != '') {
      var finalQuestion = userQuestion;
      finalQuestion = finalQuestion.replaceAll('X', '*');
      Parser p = Parser();
      Expression exp = p.parse(finalQuestion);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      userQuestion = eval.toString();
      userAnswer = userQuestion;
    }
  }
}
