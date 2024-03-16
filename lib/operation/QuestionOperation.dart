import 'dart:math';

import 'package:flashcards_quiz/main.dart';
import 'package:flashcards_quiz/models/flutter_topics_model.dart';
import 'package:postgrest/src/postgrest_builder.dart';
import 'package:postgrest/src/types.dart';
import 'package:uuid/uuid.dart';

class QuestionOperation {
  String questionTableName = "questions_table";
  String questionIdentityName = "questions_identity";
  String questionDataName = "questions_data";
  String questionIdName = "questions_id";

  PostgrestFilterBuilder saveQuestion(
      String questionId, String questionIdentity, QuestionData questionData,
      {String? offlineIdentity}) {
    return SupabaseConfig.client.from(questionTableName).insert({
      questionIdentityName: questionIdentity,
      questionDataName: questionData.toJson(),
      questionIdName: questionId,
    });
  }

  PostgrestFilterBuilder updateQuestion(
      String questionId, QuestionData questionData) {
    return SupabaseConfig.client.from(questionTableName).update({
      questionDataName: questionData.toJson(),
    }).eq(questionIdName, questionId);
  }

  PostgrestFilterBuilder<PostgrestList> getAllQuestions() {
    return SupabaseConfig.client.from(questionTableName).select();
  }

  PostgrestFilterBuilder removeThisQuestion(String questionId) {
    return SupabaseConfig.client
        .from(questionTableName)
        .delete()
        .eq(questionIdName, questionId);
  }

  String generateUUID() {
    const uuid = Uuid();
    return uuid.v4(); // Generates a version 4 UUID
  }
}
