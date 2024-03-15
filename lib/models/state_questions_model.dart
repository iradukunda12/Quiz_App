// class StateQuestion {
//   final int id;
//   final String text;
//   final List<StateOption> options;
//   bool isLocked;
//   StateOption? selectedWiidgetOption;
//   StateOption? correctAnswer;
//
//   StateQuestion({
//     required this.text,
//     required this.options,
//     this.isLocked = false,
//     this.selectedWiidgetOption,
//     required this.id,
//     required this.correctAnswer,
//   });
//   StateQuestion copyWith() {
//     return StateQuestion(
//       id: id,
//       text: text,
//       options: options
//           .map((option) =>
//               StateOption(text: option.text, isCorrect: option.isCorrect))
//           .toList(),
//       isLocked: isLocked,
//       selectedWiidgetOption: selectedWiidgetOption,
//       correctAnswer: correctAnswer,
//     );
//   }
// }
//
// class StateOption {
//   final String text;
//   final bool isCorrect;
//
//   const StateOption({
//     required this.text,
//     required this.isCorrect,
//   });
// }

import 'package:flashcards_quiz/models/layout_questions_model.dart';

import 'flutter_topics_model.dart';

final stateQuestionsList = [
  QuestionData(
    question:
        "I am a simple method to manage state within a StatefulWidget. What am I?",
    options: [
      const QuestionOptions(text: "MobX", isCorrect: false),
      const QuestionOptions(text: "Bloc", isCorrect: false),
      const QuestionOptions(text: "setState", isCorrect: true),
      const QuestionOptions(text: "Riverpod", isCorrect: false),
    ]
  ),
  QuestionData(
    question:
        "I am a Flutter package that enables reactive programming and observable state objects. ",
    options: [
      const QuestionOptions(text: "Riverpod", isCorrect: false),
      const QuestionOptions(text: "Mobx", isCorrect: true),
      const QuestionOptions(text: "Provider", isCorrect: false),
      const QuestionOptions(text: "setState", isCorrect: false),
    ]
  ),
  QuestionData(
    question:
        "What is the name of the Flutter state management approach that uses a widget tree to hold the app state and update the UI, and is similar to Provider?",
    options: [
      const QuestionOptions(text: "Riverpod", isCorrect: true),
      const QuestionOptions(text: "Bloc", isCorrect: false),
      const QuestionOptions(text: "Redux", isCorrect: false),
      const QuestionOptions(text: "Mobx", isCorrect: false),
    ]
  ),

  QuestionData(
    question:
        "I am a lightweight and powerful solution for Flutter, combining state management and dependency injection. What am I?",
    options: [
      const QuestionOptions(text: "Getx", isCorrect: true),
      const QuestionOptions(text: "Riverpod", isCorrect: false),
      const QuestionOptions(text: "Redux", isCorrect: false),
      const QuestionOptions(text: "Get_it", isCorrect: false),
    ]
  ),
  // other 4
  QuestionData(
    question:
        "I am a feature of ****** that allows developers to navigate between routes without using context. What am I?",
    options: [
      const QuestionOptions(text: "Mobx", isCorrect: false),
      const QuestionOptions(text: "InheritedWidgets", isCorrect: false),
      const QuestionOptions(text: "Provider", isCorrect: false),
      const QuestionOptions(text: "Getx", isCorrect: true),
    ]
  ),
  QuestionData(
    question: "I use streams and sinks for state management, who am I?",
    options: [
      const QuestionOptions(text: "Bloc", isCorrect: true),
      const QuestionOptions(text: "GetX", isCorrect: false),
      const QuestionOptions(text: "Provider", isCorrect: false),
      const QuestionOptions(text: "InheritedWidgets", isCorrect: false),
    ]
  ),

  QuestionData(
    question: "I allow using React-like hooks in Flutter, who am I?",
    options: [
      const QuestionOptions(text: "GetX", isCorrect: false),
      const QuestionOptions(text: "Redux", isCorrect: false),
      const QuestionOptions(text: "Mobx", isCorrect: false),
      const QuestionOptions(text: "Hooks", isCorrect: true),
    ]
  ),
  QuestionData(
    question:
        "I am a Flutter package that helps manage state by providing a way to handle scoped state. What am I?",
    options: [
      const QuestionOptions(text: "Scoped Model", isCorrect: true),
      const QuestionOptions(text: "Flutter Hooks", isCorrect: false),
      const QuestionOptions(text: "Provider", isCorrect: false),
      const QuestionOptions(text: "GetX", isCorrect: false),
    ]
  ),

  QuestionData(
    question:
        " I am the method in a StatefulWidget that is called when the widget is being removed from the widget tree. What am I?",
    options: [
      const QuestionOptions(text: "initState()", isCorrect: false),
      const QuestionOptions(text: "onDestroy()", isCorrect: false),
      const QuestionOptions(text: "dispose()", isCorrect: true),
      const QuestionOptions(text: "setState()", isCorrect: false),
    ]
  ),

  QuestionData(
    question:
        "I am the first thing that happens when a Flutter app is launched. I am called by the Dart VM. What am I?",
    options: [
      const QuestionOptions(text: "main()", isCorrect: true),
      const QuestionOptions(text: "onDestroy()", isCorrect: false),
      const QuestionOptions(text: "dispose()", isCorrect: false),
      const QuestionOptions(text: "onCreate()", isCorrect: false),
    ]
  ),

  QuestionData(
    question:
        "I am called after the main() function. I am responsible for creating the Flutter app's root widget. What am I?",
    options: [
      const QuestionOptions(text: "main()", isCorrect: false),
      const QuestionOptions(text: "runApp()", isCorrect: true),
      const QuestionOptions(text: "dispose()", isCorrect: false),
      const QuestionOptions(text: "onCreate()", isCorrect: false),
    ]
  ),

  QuestionData(
    question:
        "I am a method that notifies the framework that the internal state of a StatefulWidget has changed. This triggers a rebuild. What am I?",
    options: [
      const QuestionOptions(text: "Provider", isCorrect: false),
      const QuestionOptions(text: "runApp()", isCorrect: false),
      const QuestionOptions(text: "setState()", isCorrect: true),
      const QuestionOptions(text: "onCreate()", isCorrect: false),
    ]
  ),
];
