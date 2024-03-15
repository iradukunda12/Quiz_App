import 'package:flutter/material.dart';

import '../main.dart';

class NavigationsOption {
  final String text;
  final bool isCorrect;

  const NavigationsOption({
    required this.text,
    required this.isCorrect,
  });
}

class NavigateQuestion {
  final String text;
  final List<NavigationsOption> options;
  final int id;
  final NavigationsOption correctAnswer;

  const NavigateQuestion({
    required this.text,
    required this.options,
    required this.id,
    required this.correctAnswer,
  });
}

class NavigationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Navigation Questions'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: navigateQuestionsList.length,
            itemBuilder: (context, index) {
              NavigateQuestion question = navigateQuestionsList[index];
              return Card(
                elevation: 2.0,
                margin: EdgeInsets.only(bottom: 16.0),
                child: ListTile(
                  title: Text(
                    question.text,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var option in question.options)
                            Text(
                              '${option.text} ${option.isCorrect ? "(Correct)" : ""}',
                              style: TextStyle(
                                color: option.isCorrect
                                    ? Colors.green
                                    : Colors.black,
                              ),
                            ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.edit,
                        color: bgColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

final navigateQuestionsList = [
  NavigateQuestion(
    text:
        "I am a widget that manages a stack of child widgets and allows for navigating between them. What am I?",
    options: [
      const NavigationsOption(text: "Route", isCorrect: false),
      const NavigationsOption(text: "Scaffold", isCorrect: false),
      const NavigationsOption(text: "Navigator", isCorrect: true),
      const NavigationsOption(text: "PageView", isCorrect: false),
    ],
    id: 0,
    correctAnswer: const NavigationsOption(text: "Navigator", isCorrect: true),
  ),

  NavigateQuestion(
    text:
        "I am a method that closes routes until a condition is met. Who am I?",
    options: [
      const NavigationsOption(text: "Navigator.exitUntil()", isCorrect: false),
      const NavigationsOption(
          text: "Navigator.closeAllUntil(),", isCorrect: false),
      const NavigationsOption(text: "Navigator.popWhile()", isCorrect: false),
      const NavigationsOption(text: " Navigator.popUntil()", isCorrect: true),
    ],
    id: 6,
    correctAnswer:
        const NavigationsOption(text: " Navigator.popUntil()", isCorrect: true),
  ),
  NavigateQuestion(
    text:
        "I am an event fired when a route is popped to transition back. Who am I?",
    options: [
      const NavigationsOption(text: "onWillPop", isCorrect: true),
      const NavigationsOption(text: "onPop", isCorrect: false),
      const NavigationsOption(text: "didPop", isCorrect: false),
      const NavigationsOption(text: "popRoute", isCorrect: false),
    ],
    id: 7,
    correctAnswer: const NavigationsOption(text: "onWillPop", isCorrect: true),
  ),

  NavigateQuestion(
    text:
        "I am a method that adds a route to the history without removing current. Who am I?",
    options: [
      const NavigationsOption(text: "openRoute()", isCorrect: false),
      const NavigationsOption(text: "onDestroy()", isCorrect: false),
      const NavigationsOption(text: "Navigator.push()", isCorrect: true),
      const NavigationsOption(text: "overlayRoute()", isCorrect: false),
    ],
    id: 8,
    correctAnswer:
        const NavigationsOption(text: "Navigator.push()", isCorrect: true),
  ),

  // Continue with the rest of your navigation questions...
];
