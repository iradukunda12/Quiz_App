// import 'package:flutter/material.dart';

// import '../main.dart';

// class StateOption {
//   final String text;
//   final bool isCorrect;

//   const StateOption({
//     required this.text,
//     required this.isCorrect,
//   });
// }

// class StateQuestion {
//   final String text;
//   final List<StateOption> options;
//   final int id;
//   final StateOption correctAnswer;

//   const StateQuestion({
//     required this.text,
//     required this.options,
//     required this.id,
//     required this.correctAnswer,
//   });
// }

// void main() {
//   runApp(MyAppStateManagementApp());
// }

// class MyAppStateManagementApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('State Management Questions'),
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ),
//         body: Container(
//           padding: EdgeInsets.all(16.0),
//           child: ListView.builder(
//             itemCount: stateQuestionsList.length,
//             itemBuilder: (context, index) {
//               StateQuestion question = stateQuestionsList[index];
//               return Card(
//                 elevation: 2.0,
//                 margin: EdgeInsets.only(bottom: 16.0),
//                 child: ListTile(
//                   title: Text(
//                     question.text,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   subtitle: Row(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           for (var option in question.options)
//                             Text(
//                               '${option.text} ${option.isCorrect ? "(Correct)" : ""}',
//                               style: TextStyle(
//                                 color:
//                                     option.isCorrect ? Colors.green : Colors.black,
//                               ),
//                             ),
//                         ],
//                       ),
//                       const Spacer(),
//                       const Icon(
//                         Icons.edit,
//                         color: bgColor,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Icon(
//                         Icons.delete,
//                         color: Colors.red,
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// final stateQuestionsList = [
//   StateQuestion(
//     text:
//         "I am a simple method to manage state within a StatefulWidget. What am I?",
//     options: [
//       const StateOption(text: "MobX", isCorrect: false),
//       const StateOption(text: "Bloc", isCorrect: false),
//       const StateOption(text: "setState", isCorrect: true),
//       const StateOption(text: "Riverpod", isCorrect: false),
//     ],
//     id: 0,
//     correctAnswer: const StateOption(text: "setState", isCorrect: true),
//   ),
//   StateQuestion(
//     text:
//         " I am the method in a StatefulWidget that is called when the widget is being removed from the widget tree. What am I?",
//     options: [
//       const StateOption(text: "initState()", isCorrect: false),
//       const StateOption(text: "onDestroy()", isCorrect: false),
//       const StateOption(text: "dispose()", isCorrect: true),
//       const StateOption(text: "setState()", isCorrect: false),
//     ],
//     id: 8,
//     correctAnswer: const StateOption(text: "dispose()", isCorrect: true),
//   ),

//   StateQuestion(
//     text:
//         "I am the first thing that happens when a Flutter app is launched. I am called by the Dart VM. What am I?",
//     options: [
//       const StateOption(text: "main()", isCorrect: true),
//       const StateOption(text: "onDestroy()", isCorrect: false),
//       const StateOption(text: "dispose()", isCorrect: false),
//       const StateOption(text: "onCreate()", isCorrect: false),
//     ],
//     id: 9,
//     correctAnswer: const StateOption(text: "main()", isCorrect: true),
//   ),

//   StateQuestion(
//     text:
//         "I am called after the main() function. I am responsible for creating the Flutter app's root widget. What am I?",
//     options: [
//       const StateOption(text: "main()", isCorrect: false),
//       const StateOption(text: "runApp()", isCorrect: true),
//       const StateOption(text: "dispose()", isCorrect: false),
//       const StateOption(text: "onCreate()", isCorrect: false),
//     ],
//     id: 10,
//     correctAnswer: const StateOption(text: "runApp()", isCorrect: true),
//   ),

//   StateQuestion(
//     text:
//         "I am a method that notifies the framework that the internal state of a StatefulWidget has changed. This triggers a rebuild. What am I?",
//     options: [
//       const StateOption(text: "Provider", isCorrect: false),
//       const StateOption(text: "runApp()", isCorrect: false),
//       const StateOption(text: "setState()", isCorrect: true),
//       const StateOption(text: "onCreate()", isCorrect: false),
//     ],
//     id: 11,
//     correctAnswer: const StateOption(text: "setState()", isCorrect: true),
//   ),
//   // Continue with the rest of your state management questions...
// ];

import 'package:flashcards_quiz/main.dart';
import 'package:flutter/material.dart';

class StateOption {
  final String text;
  final bool isCorrect;

  const StateOption({
    required this.text,
    required this.isCorrect,
  });
}

class StateQuestion {
  final String text;
  final List<StateOption> options;
  final int id;
  final StateOption correctAnswer;

  const StateQuestion({
    required this.text,
    required this.options,
    required this.id,
    required this.correctAnswer,
  });
}

class StateManagementView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: bgColor3,
          title: Text(
            'State Management Questions',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: StateManagementQuestionsList(),
      ),
    );
  }
}

class StateManagementQuestionsList extends StatefulWidget {
  @override
  _StateManagementQuestionsListState createState() =>
      _StateManagementQuestionsListState();
}

class _StateManagementQuestionsListState
    extends State<StateManagementQuestionsList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: stateQuestionsList.length,
            itemBuilder: (context, index) {
              StateQuestion question = stateQuestionsList[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 4,
                  child: ListTile(
                    title: Text(
                      question.text,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(),
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
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _showEditQuestionDialog(context, question);
                          },
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
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showEditQuestionDialog(BuildContext context, StateQuestion question) {
    TextEditingController questionController =
        TextEditingController(text: question.text);
    List<TextEditingController> optionControllers = [];

    for (var i = 0; i < question.options.length; i++) {
      optionControllers.add(
        TextEditingController(text: question.options[i].text),
      );
    }

    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Question'),
          content: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Question:'),
                TextFormField(
                  controller: questionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a question';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text('Options:'),
                for (var i = 0; i < optionControllers.length; i++)
                  TextFormField(
                    controller: optionControllers[i],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter option ${i + 1}';
                      }
                      return null;
                    },
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // Implement save functionality
                  // Retrieve data from controllers: questionController.text, optionControllers[i].text
                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

final stateQuestionsList = [
  StateQuestion(
    text:
        "I am a simple method to manage state within a StatefulWidget. What am I?",
    options: [
      const StateOption(text: "MobX", isCorrect: false),
      const StateOption(text: "Bloc", isCorrect: false),
      const StateOption(text: "setState", isCorrect: true),
      const StateOption(text: "Riverpod", isCorrect: false),
    ],
    id: 0,
    correctAnswer: const StateOption(text: "setState", isCorrect: true),
  ),
  StateQuestion(
    text:
        " I am the method in a StatefulWidget that is called when the widget is being removed from the widget tree. What am I?",
    options: [
      const StateOption(text: "initState()", isCorrect: false),
      const StateOption(text: "onDestroy()", isCorrect: false),
      const StateOption(text: "dispose()", isCorrect: true),
      const StateOption(text: "setState()", isCorrect: false),
    ],
    id: 8,
    correctAnswer: const StateOption(text: "dispose()", isCorrect: true),
  ),

  StateQuestion(
    text:
        "I am the first thing that happens when a Flutter app is launched. I am called by the Dart VM. What am I?",
    options: [
      const StateOption(text: "main()", isCorrect: true),
      const StateOption(text: "onDestroy()", isCorrect: false),
      const StateOption(text: "dispose()", isCorrect: false),
      const StateOption(text: "onCreate()", isCorrect: false),
    ],
    id: 9,
    correctAnswer: const StateOption(text: "main()", isCorrect: true),
  ),

  StateQuestion(
    text:
        "I am called after the main() function. I am responsible for creating the Flutter app's root widget. What am I?",
    options: [
      const StateOption(text: "main()", isCorrect: false),
      const StateOption(text: "runApp()", isCorrect: true),
      const StateOption(text: "dispose()", isCorrect: false),
      const StateOption(text: "onCreate()", isCorrect: false),
    ],
    id: 10,
    correctAnswer: const StateOption(text: "runApp()", isCorrect: true),
  ),

  StateQuestion(
    text:
        "I am a method that notifies the framework that the internal state of a StatefulWidget has changed. This triggers a rebuild. What am I?",
    options: [
      const StateOption(text: "Provider", isCorrect: false),
      const StateOption(text: "runApp()", isCorrect: false),
      const StateOption(text: "setState()", isCorrect: true),
      const StateOption(text: "onCreate()", isCorrect: false),
    ],
    id: 11,
    correctAnswer: const StateOption(text: "setState()", isCorrect: true),
  ),
  // Add more questions...
];
