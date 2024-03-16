import 'dart:async';

import 'package:flashcards_quiz/models/flutter_topics_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:widget_state_notifier/widget_state_notifier.dart';

class QuestionImplement {
  BuildContext? get getContext => null;

  int? get getHasCode => null;
}

class QuestionNotifier {
  WidgetStateNotifier<List<QuestionData>> questionsNotifier;
  WidgetStateNotifier<List<QuestionData>> stateNotifier = WidgetStateNotifier();

  final String? _questionTitle;
  List<QuestionData> _questions = [];
  final Map<int, QuestionImplement?> _questionImplement = {};

  final Map<int, StreamSubscription?> _streamSubscriptionMap = {};

  QuestionNotifier(this._questionTitle, this.questionsNotifier);

  void attach(QuestionImplement questionImplement) {
    if (questionImplement.getHasCode != null &&
        questionImplement.getContext != null) {
      _questionImplement[questionImplement.getHasCode!] = questionImplement;
      _getTitleQuestions();
      _streamSubscriptionMap[questionImplement.getHasCode!] =
          questionsNotifier.stream.listen((event) {
        _getTitleQuestions();
      });
    }
  }

  void _getTitleQuestions() {
    _questions = (questionsNotifier.currentValue
                ?.where((element) => element.questionTitle == _questionTitle))
            ?.toList() ??
        [];
    _sendUpdate();
  }

  void _sendUpdate() {
    stateNotifier.sendNewState(_questions);
  }

  void detach(QuestionImplement questionImplement) {
    int? hasCode = questionImplement.getHasCode;
    if (hasCode != null && _streamSubscriptionMap.containsKey(hasCode)) {
      _streamSubscriptionMap[hasCode]?.cancel();
      _streamSubscriptionMap[hasCode] = null;
    }
  }

  List<QuestionData> getLatestQuestions() {
    return _questions;
  }
}
