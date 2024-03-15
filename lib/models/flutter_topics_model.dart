import 'package:flashcards_quiz/models/layout_questions_model.dart';
import 'package:flashcards_quiz/models/naviagation_questions_model.dart';
import 'package:flashcards_quiz/models/widget_questions_model.dart';
import 'package:flashcards_quiz/models/state_questions_model.dart';
import 'package:flutter/cupertino.dart';

const Color cardColor = Color(0xFF4993FA);

class FlutterTopics {
  final String topicName;
  final IconData topicIcon;
  final Color topicColor;
  final List<QuestionData> topicQuestions;

  FlutterTopics({
    required this.topicColor,
    required this.topicIcon,
    required this.topicName,
    required this.topicQuestions,
  });

  FlutterTopics copyWith({
    String? topicName,
    IconData? topicIcon,
    Color? topicColor,
    List<QuestionData>? topicQuestions,
  }) {
    return FlutterTopics(
      topicName: topicName ?? this.topicName,
      topicIcon: topicIcon ?? this.topicIcon,
      topicColor: topicColor ?? this.topicColor,
      topicQuestions: topicQuestions ?? this.topicQuestions,
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'topicName': topicName,
      'topicIcon': topicIcon.codePoint,
      'topicColor': topicColor.value,
      'topicQuestions': topicQuestions.map((question) => question.toJson()).toList(),
    };
  }

  factory FlutterTopics.fromJson(Map<dynamic, dynamic> json) {
    return FlutterTopics(
      topicName: json['topicName'],
      topicIcon: IconData(json['topicIcon'], fontFamily: 'MaterialIcons'),
      topicColor: Color(json['topicColor']),
      topicQuestions: List<QuestionData>.from(json['topicQuestions'].map((question) => QuestionData.fromJson(question))),
    );
  }
}

class QuestionData {
  final String question;
  final List<QuestionOptions> options;
  bool isLocked;

  QuestionData({
    required this.question,
    required this.options,
    this.isLocked = false,
  });

  QuestionData copyWith({
    String? question,
    List<QuestionOptions>? options,
    bool? isLocked,
  }) {
    return QuestionData(
      question: question ?? this.question,
      options: options ?? this.options,
      isLocked: isLocked ?? this.isLocked,
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'question': question,
      'options': options.map((option) => option.toJson()).toList(),
      'isLocked': isLocked,
    };
  }

  factory QuestionData.fromJson(Map<dynamic, dynamic> json) {
    return QuestionData(
      question: json['question'],
      options: List<QuestionOptions>.from(json['options'].map((option) => QuestionOptions.fromJson(option))),
      isLocked: json['isLocked'],
    );
  }
}

class QuestionOptions {
  final String text;
  final bool isCorrect;

  const QuestionOptions({
    required this.text,
    required this.isCorrect,
  });

  QuestionOptions copyWith({
    String? text,
    bool? isCorrect,
  }) {
    return QuestionOptions(
      text: text ?? this.text,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'text': text,
      'isCorrect': isCorrect,
    };
  }

  factory QuestionOptions.fromJson(Map<dynamic, dynamic> json) {
    return QuestionOptions(
      text: json['text'],
      isCorrect: json['isCorrect'],
    );
  }
}


final List<FlutterTopics> flutterTopicsList = [
  FlutterTopics(
    topicColor: cardColor,
    topicIcon: CupertinoIcons.square_stack_3d_up,
    topicName: "Widgets",
    topicQuestions: widgetQuestionsList,
  ),
  FlutterTopics(
    topicColor: cardColor,
    topicIcon: CupertinoIcons.arrow_2_circlepath,
    topicName: "State Management",
    topicQuestions: stateQuestionsList,
  ),
  FlutterTopics(
    topicColor: cardColor,
    topicIcon: CupertinoIcons.paperplane,
    topicName: "Navigation and Routing",
    topicQuestions: navigateQuestionsList,
  ),
  FlutterTopics(
    topicColor: cardColor,
    topicIcon: CupertinoIcons.rectangle_arrow_up_right_arrow_down_left,
    topicName: "Layouts and UI",
    topicQuestions: layOutQuestionsList,
  ),
];
