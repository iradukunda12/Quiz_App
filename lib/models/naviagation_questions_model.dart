// class NavigateQuestion {
//   final int id;
//   final String text;
//   final List<NavigationsOption> options;
//   bool isLocked;
//   NavigationsOption? selectedWiidgetOption;
//   NavigationsOption? correctAnswer;
//
//   NavigateQuestion({
//     required this.text,
//     required this.options,
//     this.isLocked = false,
//     this.selectedWiidgetOption,
//     required this.id,
//     required this.correctAnswer,
//   });
//
//   NavigateQuestion copyWith() {
//     return NavigateQuestion(
//       id: id,
//       text: text,
//       options: options
//           .map((option) =>
//               NavigationsOption(text: option.text, isCorrect: option.isCorrect))
//           .toList(),
//       isLocked: isLocked,
//       selectedWiidgetOption: selectedWiidgetOption,
//       correctAnswer: correctAnswer,
//     );
//   }
// }
//
// class NavigationsOption {
//   final String text;
//   final bool isCorrect;
//
//   const NavigationsOption({
//     required this.text,
//     required this.isCorrect,
//   });
// }

import 'layout_questions_model.dart';

final navigateQuestionsList = [
  QuestionData(
    question:
        "I am a widget that manages a stack of child widgets and allows for navigating between them. What am I?",
    options: [
      const QuestionOptions(text: "Route", isCorrect: false),
      const QuestionOptions(text: "Scaffold", isCorrect: false),
      const QuestionOptions(text: "Navigator", isCorrect: true),
      const QuestionOptions(text: "PageView", isCorrect: false),
    ],
  ),
  QuestionData(
    question:
        " I am a method that removes the current route from the stack and returns to the previous route. What am I?",
    options: [
      const QuestionOptions(text: "Navigator.push()", isCorrect: false),
      const QuestionOptions(text: "Navigator.pop()", isCorrect: true),
      const QuestionOptions(
          text: "Navigator.removeRoute()", isCorrect: false),
      const QuestionOptions(text: " Route.dispose()", isCorrect: false),
    ],
  ),
  QuestionData(
    question:
        "I am a widget property that must be passed to navigation methods like Navigator.push() to specify the next screen. What am I?",
    options: [
      const QuestionOptions(text: "context", isCorrect: true),
      const QuestionOptions(text: "Scaffold", isCorrect: false),
      const QuestionOptions(text: "State", isCorrect: false),
      const QuestionOptions(text: "Build", isCorrect: false),
    ],
  ),

  QuestionData(
    question:
        " I am the method that closes all routes in the history stack to pop to the first route. What am I?",
    options: [
      const QuestionOptions(text: "Navigator.popUntil()", isCorrect: true),
      const QuestionOptions(text: " Navigator.reset()", isCorrect: false),
      const QuestionOptions(text: " Navigator.exitAll()", isCorrect: false),
      const QuestionOptions(text: "Navigator.clear()", isCorrect: false),
    ],
  ),
  // other 4
  QuestionData(
    question:
        " I am a method that adds a named route to the top of the navigator stack. Who am I?",
    options: [
      const QuestionOptions(text: "Navigator.navigate()", isCorrect: false),
      const QuestionOptions(text: " Navigator.openRoute()", isCorrect: false),
      const QuestionOptions(text: " Navigator.routeTo()", isCorrect: false),
      const QuestionOptions(text: " Navigator.pushNamed()", isCorrect: true),
    ]
  ),
  QuestionData(
    question:
        " I am a method that replaces the entire route stack with a single route. Who am I?",
    options: [
      const QuestionOptions(
          text: " Navigator.pushReplacement()", isCorrect: true),
      const QuestionOptions(text: "Navigator.reset()", isCorrect: false),
      const QuestionOptions(
          text: " Navigator.replaceAll()", isCorrect: false),
      const QuestionOptions(
          text: "  Navigator.clearPush()", isCorrect: false),
    ]
  ),

  QuestionData(
    question:
        "I am a method that closes routes until a condition is met. Who am I?",
    options: [
      const QuestionOptions(text: "Navigator.exitUntil()", isCorrect: false),
      const QuestionOptions(
          text: "Navigator.closeAllUntil(),", isCorrect: false),
      const QuestionOptions(text: "Navigator.popWhile()", isCorrect: false),
      const QuestionOptions(text: " Navigator.popUntil()", isCorrect: true),
    ],
  ),
  QuestionData(
    question:
        "I am an event fired when a route is popped to transition back. Who am I?",
    options: [
      const QuestionOptions(text: "onWillPop", isCorrect: true),
      const QuestionOptions(text: "onPop", isCorrect: false),
      const QuestionOptions(text: "didPop", isCorrect: false),
      const QuestionOptions(text: "popRoute", isCorrect: false),
    ],
  ),

  QuestionData(
    question:
        "I am a method that adds a route to the history without removing current. Who am I?",
    options: [
      const QuestionOptions(text: "openRoute()", isCorrect: false),
      const QuestionOptions(text: "onDestroy()", isCorrect: false),
      const QuestionOptions(text: "Navigator.push()", isCorrect: true),
      const QuestionOptions(text: "overlayRoute()", isCorrect: false),
    ]
  ),
];
