import 'package:flashcards_quiz/models/flutter_topics_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:widget_state_notifier/widget_state_notifier.dart';

class QuestionImplement {
  BuildContext? get context => null;
}

class QuestionNotifier {
  WidgetStateNotifier<List<QuestionData>> stateNotifier = WidgetStateNotifier();

  String? _questionTitle;
  List<QuestionData> _questions = [];
  QuestionImplement? _questionImplement;

  QuestionNotifier(this._questionTitle, this._questions);

  QuestionNotifier start(QuestionImplement questionImplement,
      {bool startFetching = true}) {
    BuildContext? buildContext = questionImplement.context;
    if (buildContext != null) {
      _questionImplement = questionImplement;
      if (startFetching) {
        _startFetching();
        if (_questions.isNotEmpty) {
          _sendUpdate();
        }
      }
    }
    return this;
  }

  void _startFetching() async {}

  void _sendUpdate() {
    stateNotifier.sendNewState(_questions);
  }

  List<QuestionData> getLatestQuestions() {
    return _questions;
  }
}
