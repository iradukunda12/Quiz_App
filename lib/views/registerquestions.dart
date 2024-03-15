import 'package:flashcards_quiz/views/home_screen.dart';
import 'package:flutter/material.dart';

class RegisterQuestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: QuizForm(),
    );
  }
}

class QuizForm extends StatefulWidget {
  @override
  _QuizFormState createState() => _QuizFormState();
}

class _QuizFormState extends State<QuizForm> {
  final TextEditingController _questionController = TextEditingController();
  final List<TextEditingController> _optionControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  List<bool> _correctAnswers = [false, false, false, false];

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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
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
