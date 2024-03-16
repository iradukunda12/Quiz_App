import 'package:flashcards_quiz/main.dart';
import 'package:flashcards_quiz/models/flutter_topics_model.dart';
import 'package:postgrest/src/postgrest_builder.dart';
import 'package:postgrest/src/types.dart';

class QuestionOperation {
  PostgrestFilterBuilder saveQuestion(
      String questionIdentity, QuestionData questionData) {
    return SupabaseConfig.client.from("questions_table").insert({
      "questions_identity": questionIdentity,
      "questions_data": questionData.toJson(),
    });
  }

  PostgrestFilterBuilder<PostgrestList> getAllQuestions() {
    return SupabaseConfig.client.from("questions_table").select();
  }
}
