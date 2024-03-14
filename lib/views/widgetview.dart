// import 'package:flashcards_quiz/main.dart';
// import 'package:flutter/material.dart';

// class LayOutOption {
//   final String text;
//   final bool isCorrect;

//   const LayOutOption({
//     required this.text,
//     required this.isCorrect,
//   });
// }

// class LayOutQuestion {
//   final String text;
//   final List<LayOutOption> options;
//   final int id;
//   final LayOutOption correctAnswer;

//   const LayOutQuestion({
//     required this.text,
//     required this.options,
//     required this.id,
//     required this.correctAnswer,
//   });
// }

// class WidgetView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: bgColor,
//         appBar: AppBar(
//           title: Text('Layout Questions'),
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ),
//         body: ListView.builder(
//           itemCount: layOutQuestionsList.length,
//           itemBuilder: (context, index) {
//             LayOutQuestion question = layOutQuestionsList[index];
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Card(
//                 elevation: 4,
//                 child: ListTile(
//                   title: Text(
//                     question.text,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Row(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Divider(),
//                           for (var option in question.options)
//                             Text(
//                               '${option.text} ${option.isCorrect ? "(Correct)" : ""}',
//                               style: TextStyle(
//                                 color: option.isCorrect
//                                     ? Colors.green
//                                     : Colors.black,
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
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// final layOutQuestionsList = [
//   LayOutQuestion(
//     text: "I control how widgets are placed vertically in a column. Who am I?",
//     options: [
//       const LayOutOption(text: "MainAxisAlignment", isCorrect: true),
//       const LayOutOption(text: "Row", isCorrect: false),
//       const LayOutOption(text: "CrossAxisAlignment", isCorrect: false),
//       const LayOutOption(text: "mainAxisSize", isCorrect: false),
//     ],
//     id: 0,
//     correctAnswer:
//         const LayOutOption(text: "MainAxisAlignment", isCorrect: true),
//   ),
//   LayOutQuestion(
//     text:
//         "I allow widgets to expand and contract based on available space. You'll always find me inside a Flex. Who am I?",
//     options: [
//       const LayOutOption(text: "Flexible", isCorrect: true),
//       const LayOutOption(text: "Expanded", isCorrect: false),
//       const LayOutOption(text: "Flex", isCorrect: false),
//       const LayOutOption(text: "mainAxisSpacing", isCorrect: false),
//     ],
//     id: 1,
//     correctAnswer: const LayOutOption(text: "Flexible", isCorrect: true),
//   ),
//   LayOutQuestion(
//     text:
//         "I align widgets to the top, bottom, center inside a Column. What am I?",
//     options: [
//       const LayOutOption(text: "Row", isCorrect: false),
//       const LayOutOption(text: "Align", isCorrect: false),
//       const LayOutOption(text: "Spacer", isCorrect: false),
//       const LayOutOption(text: "MainAxisAlignment ", isCorrect: true),
//     ],
//     id: 6,
//     correctAnswer:
//         const LayOutOption(text: "MainAxisAlignment ", isCorrect: true),
//   ),
//   LayOutQuestion(
//     text:
//         "I align my Row or Column children differently based on available space. Who am I?",
//     options: [
//       const LayOutOption(text: "Expanded", isCorrect: false),
//       const LayOutOption(text: "Flex ", isCorrect: true),
//       const LayOutOption(text: "FittedBox", isCorrect: false),
//       const LayOutOption(text: "Wrap", isCorrect: false),
//     ],
//     id: 7,
//     correctAnswer: const LayOutOption(text: "Scoped Model", isCorrect: true),
//   ),
//   // Continue with the rest of your questions...
// ];

import 'package:flashcards_quiz/main.dart';
import 'package:flutter/material.dart';

class LayOutOption {
  final String text;
  final bool isCorrect;

  const LayOutOption({
    required this.text,
    required this.isCorrect,
  });
}

class LayOutQuestion {
  final String text;
  final List<LayOutOption> options;
  final int id;
  final LayOutOption correctAnswer;

  const LayOutQuestion({
    required this.text,
    required this.options,
    required this.id,
    required this.correctAnswer,
  });
}

class WidgetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: bgColor3,
          title: Text(
            'Layout Questions',
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
        body: LayoutQuestionsList(),
      ),
    );
  }
}

class LayoutQuestionsList extends StatefulWidget {
  @override
  _LayoutQuestionsListState createState() => _LayoutQuestionsListState();
}

class _LayoutQuestionsListState extends State<LayoutQuestionsList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: layOutQuestionsList.length,
            itemBuilder: (context, index) {
              LayOutQuestion question = layOutQuestionsList[index];
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
                            const Divider(),
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

  void _showEditQuestionDialog(BuildContext context, LayOutQuestion question) {
    TextEditingController questionController =
        TextEditingController(text: question.text);
    List<TextEditingController> optionControllers = [];

    for (var i = 0; i < question.options.length; i++) {
      optionControllers.add(
        TextEditingController(text: question.options[i].text),
      );
    }

    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    void saveQuestion(){

    }

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

final layOutQuestionsList = [
  LayOutQuestion(
    text: "I control how widgets are placed vertically in a column. Who am I?",
    options: [
      const LayOutOption(text: "MainAxisAlignment", isCorrect: true),
      const LayOutOption(text: "Row", isCorrect: false),
      const LayOutOption(text: "CrossAxisAlignment", isCorrect: false),
      const LayOutOption(text: "mainAxisSize", isCorrect: false),
    ],
    id: 0,
    correctAnswer:
        const LayOutOption(text: "MainAxisAlignment", isCorrect: true),
  ),

  LayOutQuestion(
    text:
        "I allow widgets to expand and contract based on available space. You'll always find me inside a Flex. Who am I?",
    options: [
      const LayOutOption(text: "Flexible", isCorrect: true),
      const LayOutOption(text: "Expanded", isCorrect: false),
      const LayOutOption(text: "Flex", isCorrect: false),
      const LayOutOption(text: "mainAxisSpacing", isCorrect: false),
    ],
    id: 1,
    correctAnswer: const LayOutOption(text: "Flexible", isCorrect: true),
  ),
  LayOutQuestion(
    text:
        "I align widgets to the top, bottom, center inside a Column. What am I?",
    options: [
      const LayOutOption(text: "Row", isCorrect: false),
      const LayOutOption(text: "Align", isCorrect: false),
      const LayOutOption(text: "Spacer", isCorrect: false),
      const LayOutOption(text: "MainAxisAlignment ", isCorrect: true),
    ],
    id: 6,
    correctAnswer:
        const LayOutOption(text: "MainAxisAlignment ", isCorrect: true),
  ),
  LayOutQuestion(
    text:
        "I align my Row or Column children differently based on available space. Who am I?",
    options: [
      const LayOutOption(text: "Expanded", isCorrect: false),
      const LayOutOption(text: "Flex ", isCorrect: true),
      const LayOutOption(text: "FittedBox", isCorrect: false),
      const LayOutOption(text: "Wrap", isCorrect: false),
    ],
    id: 7,
    correctAnswer: const LayOutOption(text: "Scoped Model", isCorrect: true),
  ),
  // Add more questions...
];
