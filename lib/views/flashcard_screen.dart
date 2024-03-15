import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flashcards_quiz/models/layout_questions_model.dart';
import 'package:flashcards_quiz/views/quiz_screen.dart';
import 'package:flashcards_quiz/widgets/flash_card_widget.dart';
import 'package:flashcards_quiz/widgets/linear_progress_indicator_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class NewCard extends StatefulWidget {
  final String topicName;
  final List<QuestionData> questionData;
  const NewCard(
      {super.key, required this.topicName, required this.questionData});

  @override
  State<NewCard> createState() => _NewCardState();
}

class _NewCardState extends State<NewCard> {
  final AppinioSwiperController controller = AppinioSwiperController();

  @override
  Widget build(BuildContext context) {
    //const Color bgColor = Color(0xFF4993FA);
    const Color bgColor3 = Color(0xFF5170FD);
    const Color cardColor = Color(0xFF4993FA);

    // Get a list of 4 randomly selected Questions objects
    final questions = getRandomQuestionsAndOptions(widget.questionData);

    // dynamic randomOptions = randomQuestionsMap.values.toList();

    return Scaffold(
      backgroundColor: bgColor3,
      body: SafeArea(
        child: Center(
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(right: 18.0),
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        CupertinoIcons.clear,
                        color: Colors.white,
                        weight: 10,
                      ),
                    ),
                    MyProgressIndicator(
                      questionlenght: questions,
                      topicType: widget.topicName,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.92,
                height: MediaQuery.of(context).size.height * 0.60,
                child: AppinioSwiper(
                  padding: const EdgeInsets.all(10),
                  loop: true,
                  backgroundCardsCount: 2,
                  swipeOptions: const AppinioSwipeOptions.all(),
                  unlimitedUnswipe: true,
                  controller: controller,
                  unswipe: _unswipe,
                  onSwipe: _swipe,
                  onEnd: _onEnd,
                  cardsCount: questions.length,
                  cardsBuilder: (BuildContext context, int index) {
                    var cardIndex = questions[index];
                    return FlipCardsWidget(
                      bgColor: cardColor,
                      cardsLenght: questions.length,
                      currentIndex: index + 1,
                      answer: (cardIndex.options as List<QuestionOptions>)
                              .firstWhere((element) => element.isCorrect)
                              .text ??
                          '',
                      question: cardIndex.question,
                      currentTopic: widget.topicName,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(cardColor),
                      fixedSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width * 0.85, 30),
                      ),
                      elevation: MaterialStateProperty.all(4),
                    ),
                    onPressed: () => controller.unswipe(),
                    child: const Text(
                      "Reorder Cards",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(cardColor),
                      fixedSize: MaterialStateProperty.all(
                        Size(MediaQuery.sizeOf(context).width * 0.85, 30),
                      ),
                      elevation: MaterialStateProperty.all(4),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizScreen(
                            questions: layOutQuestionsList,
                            topicType: widget.topicName,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Start Quiz",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<QuestionData> getRandomQuestionsAndOptions(
  List<QuestionData> allQuestions,
) {
  final randomQuestions = <QuestionData>[];
  final random = Random();

  int count = allQuestions.length;

  while (randomQuestions.length < count) {
    final randomIndex = random.nextInt(allQuestions.length);
    final selectedQuestion = allQuestions[randomIndex];

    if (!randomQuestions
        .map((e) => e.question)
        .contains(selectedQuestion.question)) {
      randomQuestions.add(selectedQuestion);
    }
  }

  return randomQuestions;
}

// List<dynamic> getRandomQuestions(List<dynamic> allQuestions, int count) {
//   if (count >= allQuestions.length) {
//     return List.from(allQuestions);
//   }
//   List<dynamic> randomQuestions = [];

//   List<int> indexes = List.generate(allQuestions.length, (index) => index);
//   final random = Random();

//   while (randomQuestions.length < count) {
//     final randomIndex = random.nextInt(indexes.length);
//     final selectedQuestionIndex = indexes[randomIndex];
//     final selectedQuestion = allQuestions[selectedQuestionIndex];
//     randomQuestions.add(selectedQuestion);

//     indexes.removeAt(randomIndex);
//   }
//   return randomQuestions;
// }

void _swipe(int index, AppinioSwiperDirection direction) {
  print("the card was swiped to the: ${direction.name}");
  print(index);
}

void _unswipe(bool unswiped) {
  if (unswiped) {
    print("SUCCESS: card was unswiped");
  } else {
    print("FAIL: no card left to unswipe");
  }
}

void _onEnd() {
  print("end reached!");
}
