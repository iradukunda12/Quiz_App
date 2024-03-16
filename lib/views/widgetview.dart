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
import 'package:flashcards_quiz/views/registerquestions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:widget_state_notifier/widget_state_notifier.dart';

import '../models/flutter_topics_model.dart';
import '../notifiers/QuestionNotifier.dart';
import '../notifiers/TitleNotifier.dart';

class WidgetView extends StatefulWidget {
  final String category;
  final QuestionNotifier questionNotifier;

  const WidgetView(this.category, this.questionNotifier, {super.key});

  @override
  State<WidgetView> createState() => _WidgetViewState();
}

class _WidgetViewState extends State<WidgetView> implements QuestionImplement {
  @override
  BuildContext? get getContext => context;

  @override
  int? get getHasCode => hashCode;

  @override
  void initState() {
    super.initState();

    widget.questionNotifier.attach(this);
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.questionNotifier.getLatestQuestions().isEmpty) {
      TitleNotifier().removeQuestionNotifier(widget.category);
    }
    widget.questionNotifier.detach(this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: bgColor,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterQuestion(widget.category),
                  ),
                );
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.green,
            ),
            appBar: AppBar(
              backgroundColor: bgColor3,
              title: Text(
                '${widget.category} Questions',
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
            body: SingleChildScrollView(
              child: Column(
                children: [
                  WidgetStateConsumer(
                      widgetStateNotifier:
                          widget.questionNotifier.stateNotifier,
                      widgetStateBuilder: (context, snapshot) {
                        List<QuestionData> questions = snapshot ??
                            widget.questionNotifier.getLatestQuestions();
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: questions.length,
                          itemBuilder: (context, index) {
                            QuestionData question = questions[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 4,
                                child: ListTile(
                                  title: Text(
                                    question.question,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterQuestion(
                                                widget.category,
                                                layOutQuestion: question,
                                              ),
                                            ),
                                          );
                                          // _showEditQuestionDialog(context, question);
                                        },
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Box questionBox = HiveConfig().getBox(
                                              TitleNotifier().questionBoxName);

                                          if (question.questionId != null) {
                                            questionBox
                                                .delete(question.questionId)
                                                .then((value) => null);
                                          }
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }),
                ],
              ),
            )));
  }
}
