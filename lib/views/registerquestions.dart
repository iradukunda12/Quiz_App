import 'package:flashcards_quiz/main.dart';
import 'package:flashcards_quiz/notifiers/TitleNotifier.dart';
import 'package:flashcards_quiz/operation/QuestionOperation.dart';
import 'package:flashcards_quiz/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/flutter_topics_model.dart';

class RegisterQuestion extends StatefulWidget {
  final String category;
  final QuestionData? layOutQuestion;

  RegisterQuestion(this.category, {this.layOutQuestion});

  @override
  State<RegisterQuestion> createState() => _RegisterQuestionState();
}

class _RegisterQuestionState extends State<RegisterQuestion> {
  late TextEditingController _questionController;
  late List<TextEditingController> _optionControllers;
  List<bool> _correctAnswers = [false, false, false, false];

  @override
  void initState() {
    super.initState();

    _optionControllers = [];
    _questionController =
        TextEditingController(text: widget.layOutQuestion?.question ?? '');
    if (widget.layOutQuestion?.options.length != null) {
      for (var i = 0; i < (widget.layOutQuestion?.options.length ?? 0); i++) {
        _optionControllers.add(
          TextEditingController(
              text: widget.layOutQuestion?.options[i].text ?? ''),
        );
        _correctAnswers[i] =
            widget.layOutQuestion?.options[i].isCorrect ?? false;
      }
    } else {
      _optionControllers = List.generate(
        4,
        (index) => TextEditingController(),
      );
    }
  }

  bool canSubmit() {
    return _questionController.text.isNotEmpty &&
        _optionControllers.where((element) => element.text.isEmpty).isEmpty &&
        _correctAnswers.where((element) => element).isNotEmpty;
  }

  void submitQuestions() {
    String question = _questionController.text.trim();
    QuestionOptions option1 = QuestionOptions(
        text: _optionControllers[0].text.trim(), isCorrect: _correctAnswers[0]);
    QuestionOptions option2 = QuestionOptions(
        text: _optionControllers[1].text.trim(), isCorrect: _correctAnswers[1]);
    QuestionOptions option3 = QuestionOptions(
        text: _optionControllers[2].text.trim(), isCorrect: _correctAnswers[2]);
    QuestionOptions option4 = QuestionOptions(
        text: _optionControllers[3].text.trim(), isCorrect: _correctAnswers[3]);

    Box questionBox = HiveConfig().getBox(TitleNotifier().questionBoxName);

    if (widget.layOutQuestion?.questionId != null) {
      QuestionData questionData = QuestionData(
        question: question,
        options: [option1, option2, option3, option4],
        questionId: widget.layOutQuestion?.questionId,
        questionTitle: widget.category,
      );

      //   Edit
      questionBox.delete(widget.layOutQuestion?.questionId).then((value) {
        questionBox.put(
            widget.layOutQuestion?.questionId, questionData.toJson());
        Navigator.pop(context);
      });
    } else {
      String questionId = QuestionOperation().generateUUID();

      QuestionData questionData = QuestionData(
        question: question,
        options: [option1, option2, option3, option4],
        questionId: questionId,
        questionTitle: widget.category,
      );

      //   New
      questionBox.put(questionId, questionData.toJson()).then((value) {
        TitleNotifier().restart();
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Form'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question:',
              style: TextStyle(fontSize: 16.0),
            ),
            TextField(
              controller: _questionController,
              decoration: InputDecoration(
                hintText: 'Enter your question',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Options:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Column(
              children: List.generate(
                4,
                (index) => ListTile(
                  title: TextField(
                    controller: _optionControllers[index],
                    decoration: InputDecoration(
                      hintText: 'Option ${index + 1}',
                    ),
                  ),
                  trailing: Switch(
                    value: _correctAnswers[index],
                    onChanged: (value) {
                      setState(() {
                        _correctAnswers = List.generate(4, (index) => false);
                        _correctAnswers[index] = value;
                      });
                    },
                    activeColor: Colors.blue,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle form submission here
                  print('Question: ${_questionController.text}');
                  for (int i = 0; i < 4; i++) {
                    print('Option ${i + 1}: ${_optionControllers[i].text}');
                    print('Correct Answer: ${_correctAnswers[i]}');
                  }

                  if (canSubmit()) {
                    submitQuestions();
                  } else {
                    showSnackBar(context, "Enter all Values");
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    _optionControllers.forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }
}
