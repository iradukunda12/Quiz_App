import 'package:flashcards_quiz/main.dart';
import 'package:flashcards_quiz/models/flutter_topics_model.dart';
import 'package:flashcards_quiz/notifiers/QuestionNotifier.dart';
import 'package:flashcards_quiz/operation/QuestionOperation.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:widget_state_notifier/widget_state_notifier.dart';

class TitleImplement {
  BuildContext? get getContext => null;
}

class TitleNotifier {
  static final TitleNotifier instance = TitleNotifier.internal();

  factory TitleNotifier() => instance;

  TitleNotifier.internal();

  String questionBoxName = "question_database";
  WidgetStateNotifier<List<String>> titleNotifier = WidgetStateNotifier();
  WidgetStateNotifier<List<QuestionData>> questionsNotifier =
      WidgetStateNotifier();
  List<String> titles = [];
  Map<String, QuestionNotifier> questionNotifiers = {};
  TitleImplement? _titleImplement;

  bool started = false;
  bool _savingFirst = false;

  Future<TitleNotifier> start(TitleImplement titleImplement) async {
    BuildContext? buildContext = titleImplement.getContext;
    if (buildContext != null) {
      _titleImplement = titleImplement;
      started = true;
      _startFetchingOffline();
      _startFetchingOnline();
    }
    return this;
  }

  void restart() {
    if(started){
      _startFetchingOnline();
    }
  }

  void _startFetchingOffline() {
    Box questionBox = HiveConfig().getBox(questionBoxName);

    void latestOfflineProcessor() {
      List<QuestionData> allQuestions = getOfflineQuestions();
      if (allQuestions.isNotEmpty) {
        // Send Latest Questions to Question Notifiers
        questionsNotifier.sendNewState(allQuestions);
        extractTitles(allQuestions, false);
      }
    }

    // latestOfflineProcessor();

    questionBox.listenable().addListener(() {
      if(!_savingFirst) {
        latestOfflineProcessor();
      }
    });
  }

  List<QuestionData> getOfflineQuestions() {
    Box questionBox = HiveConfig().getBox(questionBoxName);

    final keys = questionBox.keys;

    final questionData = keys.map((e) => questionBox.get(e)).toList();

    if (questionData.isNotEmpty && questionData.firstOrNull is Map) {
      List<QuestionData> allQuestions =
          questionData.map((e) => QuestionData.fromJson(e)).toList();
      return allQuestions;
    }
    return [];
  }

  void _startFetchingOnline() {
    QuestionOperation().getAllQuestions().then((questions) {
      List<QuestionData> allQuestions = questions
          .map((e) => QuestionData.fromOnline(e['questions_data'],
              e['questions_id'].toString(), e['questions_identity']))
          .toList();

      extractTitles(allQuestions, true);
    });
  }

  void extractTitles(List<QuestionData> allQuestions, bool online) {
    List<String> getTitles = [];
    bool firstTime = titles.isEmpty;

    if (firstTime || !online) {
      for (var element in allQuestions) {
        String title = element.questionTitle ?? '';

        if (!titles.contains(title) && title.isNotEmpty) {
          getTitles.add(title);
          _processGroups(
              title,
              allQuestions
                  .where((element) => element.questionTitle == title)
                  .toList());
        } else if (title.isNotEmpty) {
          getTitles.add(title);
        }
      }

      if (!firstTime && !online) {
        List<String> presentTitle = [];
        presentTitle.addAll(titles);
        for (var element in presentTitle) {
          if (!getTitles.contains(element)) {
            removeQuestionNotifier(element);
          }
        }
      }
      _sendUpdate();
    }

    if (online && firstTime) {
      saveFirstTimeLatestQuestions(allQuestions);
    } else if (online && !firstTime && isAdmin || !online && isAdmin) {
      startSyncing(allQuestions);
    }
  }

  void startSyncing(List<QuestionData> onlineQuestions) {
    List<QuestionData> offlineQuestion = getOfflineQuestions();

    List<String> offlineQuestionId =
        offlineQuestion.map((e) => e.questionId ?? '').toList();
    List<String> onlineQuestionId =
        onlineQuestions.map((e) => e.questionId ?? '').toList();

    offlineQuestionId.removeWhere((element) => element.isEmpty);
    onlineQuestionId.removeWhere((element) => element.isEmpty);

    //  Remove online question removed from device
    List<String> removedOnlineQuestions = onlineQuestionId
        .where((onlineId) => !offlineQuestionId.contains(onlineId))
        .toList();
    _removeOnlineQuestions(removedOnlineQuestions);

    //   Add new Question from device to online

    List<QuestionData> newOnlineQuestionsFromOffline = offlineQuestion
        .where(
            (offlineData) => !onlineQuestionId.contains(offlineData.questionId))
        .toList();
    saveOfflineQuestion(newOnlineQuestionsFromOffline);

    //   Update the old questions offline to online
    updateTheOnlineQuestions(offlineQuestion);
  }

  void _removeOnlineQuestions(List<String> removedOnlineQuestions) {
    for (var element in removedOnlineQuestions) {
      QuestionOperation().removeThisQuestion(element).then((value) {});
    }
  }

  void saveOfflineQuestion(List<QuestionData> newOnlineQuestionsFromOffline) {
    for (var element in newOnlineQuestionsFromOffline) {
      if (element.questionTitle != null) {
        QuestionOperation()
            .saveQuestion(QuestionOperation().generateUUID(),
                element.questionTitle!, element,
                offlineIdentity: element.questionId)
            .then((value) => null);
      }
    }
  }

  void updateTheOnlineQuestions(List<QuestionData> offlineQuestion) {
    for (var element in offlineQuestion) {
      if (element.questionId != null) {
        QuestionOperation()
            .updateQuestion(element.questionId!, element)
            .then((value) => null);
      }
    }
  }

  void saveFirstTimeLatestQuestions(List<QuestionData> allQuestions) {
    Box questionBox = HiveConfig().getBox(questionBoxName);

    questionBox.clear();

    _savingFirst = true;
    for (var question in allQuestions) {
      questionBox.put(question.questionId, question.toJson());
    }
    _savingFirst = false;
  }

  QuestionNotifier? getThisQuestionNotifier(String title,
      {List<QuestionData> question = const []}) {
    if (questionNotifiers.keys.toList().contains(title)) {
      return questionNotifiers[title];
    } else {
      QuestionNotifier questionNotifier =
          QuestionNotifier(title, questionsNotifier);
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
      titleNotifier.sendNewState(titles);
    }
  }


}
