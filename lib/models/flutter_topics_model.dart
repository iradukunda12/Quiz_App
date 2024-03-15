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
