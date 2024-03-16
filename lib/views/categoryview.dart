import 'package:flashcards_quiz/main.dart';
import 'package:flashcards_quiz/notifiers/TitleNotifier.dart';
import 'package:flashcards_quiz/utils/utils.dart';
import 'package:flashcards_quiz/views/widgetview.dart';
import 'package:flutter/material.dart';

import '../notifiers/QuestionNotifier.dart';
import 'registerquestions.dart';

class CategoryView extends StatelessWidget {
  TextEditingController _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor3,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(
          'Choose The Category',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(
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
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
                child: TextField(
                  controller: _categoryController,
                  decoration: InputDecoration(
                    hintText: 'Enter your question',
                  ),
                ),
                // DropdownButtonFormField<String>(
                //   iconDisabledColor: Colors.white,
                //   dropdownColor: Colors.white,
                //   value: _selectedCategory,
                //   hint: Text(
                //     'Select a category',
                //     style: TextStyle(color: Colors.white),
                //   ),
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       _selectedCategory = newValue;
                //     });
                //   },
                //   items: <String>[
                //     'Widget',
                //     'StateManagement',
                //     'layout & ui',
                //     'Navigation',
                //   ].map<DropdownMenuItem<String>>((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                // ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_categoryController.text.isNotEmpty) {
                    QuestionNotifier? questionNotifier = TitleNotifier()
                        .getThisQuestionNotifier(_categoryController.text);
                    if (questionNotifier != null) {
                      Navigator.push(
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
                child: Text(
                  'Proceed to Question',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
