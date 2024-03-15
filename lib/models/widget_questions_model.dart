// class WidgetQuestion {
//   final int id;
//   final String text;
//   final List<WiidgetOption> options;
//   bool isLocked;
//   WiidgetOption? selectedWiidgetOption;
//   WiidgetOption correctAnswer;
//
//   WidgetQuestion({
//     required this.text,
//     required this.options,
//     this.isLocked = false,
//     this.selectedWiidgetOption,
//     required this.id,
//     required this.correctAnswer,
//   });
//
//   WidgetQuestion copyWith() {
//     return WidgetQuestion(
//       id: id,
//       text: text,
//       options: options
//           .map((option) =>
//               WiidgetOption(text: option.text, isCorrect: option.isCorrect))
//           .toList(),
//       isLocked: isLocked,
//       selectedWiidgetOption: selectedWiidgetOption,
//       correctAnswer: correctAnswer,
//     );
//   }
// }
//
// class WiidgetOption {
//   final String? text;
//   final bool? isCorrect;
//
//   const WiidgetOption({
//     this.text,
//     this.isCorrect,
//   });
// }

import 'package:flashcards_quiz/models/layout_questions_model.dart';

final widgetQuestionsList = [
  QuestionData(
    question:
        "I am a Flutter widget that provides a scrollable list of children. What am I?",
    options: [
      const QuestionOptions(text: "ListView", isCorrect: true),
      const QuestionOptions(text: "Column", isCorrect: false),
      const QuestionOptions(text: "Row", isCorrect: false),
      const QuestionOptions(text: "Wrap", isCorrect: false),
    ]
  ),
  QuestionData(
      question:
          "I am a widget used to display a single piece of content and expand to fill the available space. What am I?",
      options: [
        const QuestionOptions(text: "Flexible", isCorrect: false),
        const QuestionOptions(text: "Expanded", isCorrect: true),
        const QuestionOptions(text: "Container", isCorrect: false),
        const QuestionOptions(text: "SizedBox", isCorrect: false),
      ]
  ),

  QuestionData(
      question:
          "I am a circular or elliptical shape with a specific radius. What am I?",
      options: [
        const QuestionOptions(text: "ClipRRect", isCorrect: false),
        const QuestionOptions(text: "DecoratedBox", isCorrect: false),
        const QuestionOptions(text: "ClipOval", isCorrect: false),
        const QuestionOptions(text: "CircleAvatar", isCorrect: true),
      ]),

  QuestionData(
      question:
          "I am a widget that creates a button with an icon and a label. What am I?",
      options: [
        const QuestionOptions(text: "Elevated Button", isCorrect: false),
        const QuestionOptions(text: "TextButton", isCorrect: false),
        const QuestionOptions(text: "IconButton", isCorrect: true),
        const QuestionOptions(text: "TextButton.icon", isCorrect: false),
      ],
  ),

  QuestionData(
      question:
          " I am a widget that provides a responsive grid of tiles with multiple children. What am I?",
      options: [
        const QuestionOptions(text: "ListTile", isCorrect: false),
        const QuestionOptions(text: "singleChildScrollView", isCorrect: false),
        const QuestionOptions(text: "ListView", isCorrect: false),
        const QuestionOptions(text: "GridView", isCorrect: true),
      ]),

  QuestionData(
      question:
          "I am a widget that creates a collapsible tile with an optional leading and trailing widget. What am I?",
      options: [
        const QuestionOptions(text: "ExpansionTile", isCorrect: true),
        const QuestionOptions(text: "DropdownButton", isCorrect: false),
        const QuestionOptions(text: "Card", isCorrect: false),
        const QuestionOptions(text: "AppBar", isCorrect: false),
      ]),
  QuestionData(
      question:
          " I am a widget that provides a rectangular box with a specified width, height, and color. What am I?",
      options: [
        const QuestionOptions(text: "Container", isCorrect: true),
        const QuestionOptions(text: "Card", isCorrect: false),
        const QuestionOptions(text: "SizedBox", isCorrect: false),
        const QuestionOptions(text: "Padding", isCorrect: false),
      ]),
  QuestionData(
      question:
          "I am a widget that displays an image from the specified network URL. What am I?",
      options: [
        const QuestionOptions(text: "Image.network", isCorrect: true),
        const QuestionOptions(text: "AssetImage", isCorrect: false),
        const QuestionOptions(text: "Image.asset", isCorrect: false),
        const QuestionOptions(text: "Image.file", isCorrect: false),
      ]),
  QuestionData(
      question:
          "I give Material apps their signature reactive ink splash effect. Who am I?",
      options: [
        const QuestionOptions(text: "InkWell", isCorrect: true),
        const QuestionOptions(text: "GestureDetector", isCorrect: false),
        const QuestionOptions(text: "AbsorbPointer", isCorrect: false),
        const QuestionOptions(text: "IgnorePointer", isCorrect: false),
      ],),
  QuestionData(
      question:
          "I am a widget that provides a material design styled line divider. What am I?",
      options: [
        const QuestionOptions(text: "Divider", isCorrect: true),
        const QuestionOptions(text: "SizedBox", isCorrect: false),
        const QuestionOptions(text: "Container", isCorrect: false),
        const QuestionOptions(text: "ListTile", isCorrect: false),
      ]),
  QuestionData(
      question:
          "I am a widget that displays a circular material design spinner to indicate loading. What am I?",
      options: [
        const QuestionOptions(text: "LinearProgressIndicator", isCorrect: false),
        const QuestionOptions(text: "RefreshIndicator", isCorrect: false),
        const QuestionOptions(text: "CircularProgressIndicator", isCorrect: true),
        const QuestionOptions(text: "LoadingIndicator", isCorrect: false),
      ]),
  QuestionData(
      question:
          "I am a widget that displays a material design styled tooltip when the user hovers over it. What am I?",
      options: [
        const QuestionOptions(text: "Popover", isCorrect: false),
        const QuestionOptions(text: "Tooltip", isCorrect: true),
        const QuestionOptions(text: "Snackbar", isCorrect: false),
        const QuestionOptions(text: "HintText", isCorrect: false),
      ],),
  QuestionData(
      question:
          "I am the folder containing assets like images, fonts, json files etc. What am I?",
      options: [
        const QuestionOptions(text: "static", isCorrect: false),
        const QuestionOptions(text: "assets", isCorrect: true),
        const QuestionOptions(text: "resources", isCorrect: false),
        const QuestionOptions(text: "images", isCorrect: false),
      ]),
  QuestionData(
      question:
          "I am the programming language used to build Flutter apps. What am I?",
      options: [
        const QuestionOptions(text: "Dart", isCorrect: true),
        const QuestionOptions(text: "Java", isCorrect: false),
        const QuestionOptions(text: "Swift", isCorrect: false),
        const QuestionOptions(text: "Kotlin", isCorrect: false),
      ],),
  QuestionData(
    question:
        "I am a mechanism that allows you to incorporate platform-specific UI elements into a Flutter app. What am I?",
    options: [
      const QuestionOptions(text: "Native view", isCorrect: false),
      const QuestionOptions(text: "Platform channels", isCorrect: true),
      const QuestionOptions(text: "JNI", isCorrect: false),
      const QuestionOptions(text: "Bridge", isCorrect: false),
    ]
  ),
  QuestionData(
    question:
        "I am a property that uniquely identifies a widget and allows it to be updated efficiently. What am I?",
    options: [
      const QuestionOptions(text: "key", isCorrect: true),
      const QuestionOptions(text: "id", isCorrect: false),
      const QuestionOptions(text: "name", isCorrect: false),
      const QuestionOptions(text: "tag", isCorrect: false),
    ],
  ),
];
