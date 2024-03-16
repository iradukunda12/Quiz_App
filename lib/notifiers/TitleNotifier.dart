import 'package:flashcards_quiz/main.dart';
import 'package:flashcards_quiz/models/flutter_topics_model.dart';
import 'package:flashcards_quiz/notifiers/QuestionNotifier.dart';
import 'package:flashcards_quiz/operation/QuestionOperation.dart';
import 'package:flutter/cupertino.dart';
import 'package:widget_state_notifier/widget_state_notifier.dart';

class TitleImplement {
  BuildContext? get getContext => null;
}

class TitleNotifier {
  static final TitleNotifier instance = TitleNotifier.internal();

  factory TitleNotifier() => instance;

  TitleNotifier.internal();

  WidgetStateNotifier<List<String>> stateNotifier = WidgetStateNotifier();
  List<String> titles = [];
  Map<String, QuestionNotifier> questionNotifiers = {};
  TitleImplement? _titleImplement;

  bool started = false;
  TitleNotifier start(TitleImplement titleImplement) {
    BuildContext? buildContext = titleImplement.getContext;
    if (buildContext != null) {
      _titleImplement = titleImplement;
      started = true;
      _startFetching();
    }
    return this;
  }

  void _startFetching() {
    QuestionOperation().getAllQuestions().then((value) {
      List<String> getTitles = [];

      for (var element in value) {
        String title = element['questions_identity'];
        if (!getTitles.contains(title)) {
          getTitles.add(title);
        }
      }

      for (var theTitle in getTitles) {
        List<QuestionData> allQuestions = value
            .where((dataValue) => dataValue['questions_identity'] == theTitle)
            .map((e) => QuestionData.fromJson(e['questions_data']))
            .toList();
        _processGroups(theTitle, allQuestions);
      }

      _sendUpdate();
    });
  }

  QuestionNotifier? getThisQuestionNotifier(String title,
      {List<QuestionData> question = const []}) {
    if (questionNotifiers.keys.toList().contains(title)) {
      return questionNotifiers[title];
    } else {
      QuestionNotifier questionNotifier = QuestionNotifier(title, question);
      questionNotifiers[title] = questionNotifier;
      return questionNotifiers[title];
    }
  }

  void createANewQuestionNotifier(String title,
      {List<QuestionData> question = const []}) {
    QuestionNotifier? thisQuestionNotifier =
        getThisQuestionNotifier(title, question: question);
    if (thisQuestionNotifier != null) {
      if (!titles.contains(title)) {
        titles.add(title);
      }
    }
    _sendUpdate();
  }

  void _processGroups(String title, List<QuestionData> allQuestions) {
    QuestionNotifier? thisQuestionNotifier =
        getThisQuestionNotifier(title, question: allQuestions);

    if (thisQuestionNotifier != null) {
      if (!titles.contains(title)) {
        titles.add(title);
      }
    }
  }

  void removeQuestionNotifier(String title) {
    if (titles.contains(title)) {
      questionNotifiers.remove(title);
      titles.remove(title);
    }
    _sendUpdate();
  }

  void _sendUpdate() {
    if (titles.isNotEmpty) {
      stateNotifier.sendNewState(titles);
    }
  }
}
