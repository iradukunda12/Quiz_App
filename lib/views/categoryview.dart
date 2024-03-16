import 'package:flashcards_quiz/main.dart';
import 'package:flashcards_quiz/notifiers/TitleNotifier.dart';
import 'package:flashcards_quiz/utils/utils.dart';
import 'package:flashcards_quiz/views/widgetview.dart';
import 'package:flutter/material.dart';

import '../notifiers/QuestionNotifier.dart';

class CategoryView extends StatelessWidget {
  final TextEditingController _categoryController = TextEditingController();

  CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor3,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: const Text(
          'Create New Category',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
                child: TextField(
                  controller: _categoryController,
                  decoration: const InputDecoration(
                    hintText: 'Enter Category',
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_categoryController.text.isNotEmpty) {
                    QuestionNotifier? questionNotifier = TitleNotifier()
                        .getThisQuestionNotifier(_categoryController.text);
                    if (questionNotifier != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WidgetView(
                              _categoryController.text, questionNotifier),
                        ),
                      );
                    } else {
                      showSnackBar(context, "An error occurred");
                    }
                  } else {
                    showSnackBar(context, "Enter the category name");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Text(
                  'Proceed to add Question',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
