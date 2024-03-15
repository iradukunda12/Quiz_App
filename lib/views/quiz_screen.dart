// import 'dart:async';

// import 'package:flashcards_quiz/models/layout_questions_model.dart';
// import 'package:flashcards_quiz/views/results_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class QuizScreen extends StatefulWidget {
//   final String topicType;
//   final List<QuestionData> questionData;
//   const QuizScreen(
//       {super.key,
//       required this.questionData,
//       required this.topicType});

//   @override
//   State<QuizScreen> createState() => _QuizScreenState();
// }

// class _QuizScreenState extends State<QuizScreen> {
//   int questionTimerSeconds = 20;
//   Timer? _timer;
//   int _questionNumber = 1;
//   PageController _controller = PageController();
//   int score = 0;
//   bool isLocked = false;
//   List optionsLetters = ["A.", "B.", "C.", "D."];

//   void startTimerOnQuestions() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (mounted) {
//         setState(() {
//           if (questionTimerSeconds > 0) {
//             questionTimerSeconds--;
//           } else {
//             _timer?.cancel();
//             navigateToNewScreen();
//           }
//         });
//       }
//     });
//   }

//   void stopTime() {
//     _timer?.cancel();
//   }

//   void navigateToNewScreen() {
//     if (_questionNumber < widget.questionData.length) {
//       _controller.nextPage(
//         duration: const Duration(milliseconds: 600),
//         curve: Curves.easeInOut,
//       );
//       setState(() {
//         _questionNumber++;
//         isLocked = false;
//       });
//       _resetQuestionLocks();
//       startTimerOnQuestions();
//     } else {
//       _timer?.cancel();
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ResultsScreen(
//             score: score,
//             totalQuestions: widget.questionData.length,
//             whichTopic: widget.topicType,
//           ),
//         ),
//       );
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _controller = PageController(initialPage: 0);
//     _resetQuestionLocks();
//     startTimerOnQuestions();
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     const Color bgColor3 = Color(0xFF5170FD);
//     const Color bgColor = Color(0xFF4993FA);

//     return WillPopScope(
//       onWillPop: () {
//         Navigator.popUntil(context, (route) => route.isFirst);
//         return Future.value(false);
//       },
//       child: Scaffold(
//         backgroundColor: bgColor3,
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 10, right: 10),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       "${widget.topicType} Quiz",
//                       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.w400),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 14, bottom: 10),
//                   child: Row(
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         icon: const Icon(
//                           CupertinoIcons.clear,
//                           color: Colors.white,
//                           weight: 10,
//                         ),
//                       ),
//                       Expanded(
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(12),
//                           child: LinearProgressIndicator(
//                             minHeight: 20,
//                             value: 1 - (questionTimerSeconds / 20),
//                             backgroundColor: Colors.blue.shade100,
//                             color: Colors.blueGrey,
//                             valueColor: const AlwaysStoppedAnimation(bgColor),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.only(top: 12, left: 10, right: 10),
//                   width: MediaQuery.of(context).size.width * 0.90,
//                   height: MediaQuery.of(context).size.height * 0.75,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.24),
//                         blurRadius: 20.0,
//                         offset: const Offset(0.0, 10.0),
//                         spreadRadius: 10,
//                       )
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Center(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Question $_questionNumber/${widget.questionData.length}",
//                             style: TextStyle(
//                                 fontSize: 16, color: Colors.grey.shade500),
//                           ),
//                           Expanded(
//                             child: PageView.builder(
//                               controller: _controller,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemCount: widget.questionData.length,
//                               onPageChanged: (value) {
//                                 setState(() {
//                                   _questionNumber = value + 1;
//                                   isLocked = false;
//                                   _resetQuestionLocks();
//                                 });
//                               },
//                               itemBuilder: (context, index) {
//                                 final questionInstance = widget.questionData[index];
//                                 var showingOptions = questionInstance.options;
//                                 bool thisIsLocked = false;
//                                 QuestionOptions? myOption;

//                                 return Column(
//                                   children: [
//                                     Text(
//                                       questionInstance.question,
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .bodyLarge!
//                                           .copyWith(
//                                             fontSize: 18,
//                                           ),
//                                     ),
//                                     const SizedBox(
//                                       height: 25,
//                                     ),
//                                     StatefulBuilder(
//                                       builder: (context, setState) {
//                                         return Expanded(
//                                           child: ListView.builder(
//                                             itemCount: questionInstance.options.length,
//                                             itemBuilder: (context, index) {
//                                               var color = Colors.grey.shade200;

//                                               final optionInstance = showingOptions[index];
//                                               final letters = optionsLetters[index];

//                                               if (thisIsLocked) {
//                                                 if (myOption == questionInstance.options.firstWhere((element) => element.isCorrect)) {
//                                                   color = myOption?.isCorrect == true
//                                                       ? Colors.green
//                                                       : Colors.red;
//                                                 } else if (myOption?.isCorrect == true) {
//                                                   color = Colors.green;
//                                                 }
//                                               }
//                                               return InkWell(
//                                                 onTap: () {
//                                                   print(myOption);
//                                                   stopTime();

//                                                   if (!thisIsLocked) {
//                                                     setState(() {
//                                                       thisIsLocked = true;
//                                                       myOption = showingOptions[index];
//                                                     });

//                                                     thisIsLocked = thisIsLocked;
//                                                     if (myOption?.isCorrect == true) {
//                                                       score++;
//                                                     }
//                                                   }
//                                                 },
//                                                 child: Container(
//                                                   height: 45,
//                                                   padding: const EdgeInsets.all(10),
//                                                   margin:
//                                                       const EdgeInsets.symmetric(
//                                                           vertical: 8),
//                                                   decoration: BoxDecoration(
//                                                     border:
//                                                         Border.all(color: color),
//                                                     color: Colors.grey.shade100,
//                                                     borderRadius:
//                                                         const BorderRadius.all(
//                                                             Radius.circular(10)),
//                                                   ),
//                                                   child: Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceBetween,
//                                                     children: [
//                                                       Text(
//                                                         "$letters ${optionInstance.text}",
//                                                         style: const TextStyle(
//                                                             fontSize: 16),
//                                                       ),
//                                                       thisIsLocked == true
//                                                           ? optionInstance.isCorrect
//                                                               ? const Icon(
//                                                                   Icons
//                                                                       .check_circle,
//                                                                   color:
//                                                                       Colors.green,
//                                                                 )
//                                                               : const Icon(
//                                                                   Icons.cancel,
//                                                                   color: Colors.red,
//                                                                 )
//                                                           : const SizedBox.shrink()
//                                                     ],
//                                                   ),
//                                                 ),
//                                               );
//                                             },
//                                           ),
//                                         );
//                                       }
//                                     ),
//                                   ],
//                                 );
//                               },
//                             ),
//                           ),
//                           isLocked
//                               ? buildElevatedButton()
//                               : const SizedBox.shrink(),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _resetQuestionLocks() {
//     for (var question in widget.questionData) {
//       question.isLocked = false;
//     }
//     questionTimerSeconds = 20;
//   }

//   ElevatedButton buildElevatedButton() {
//     //  const Color bgColor3 = Color(0xFF5170FD);
//     const Color cardColor = Color(0xFF4993FA);

//     return ElevatedButton(
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all(cardColor),
//         fixedSize: MaterialStateProperty.all(
//           Size(MediaQuery.sizeOf(context).width * 0.80, 40),
//         ),
//         elevation: MaterialStateProperty.all(4),
//       ),
//       onPressed: () {
//         if (_questionNumber < widget.questionData.length) {
//           _controller.nextPage(
//             duration: const Duration(milliseconds: 800),
//             curve: Curves.easeInOut,
//           );
//           setState(() {
//             _questionNumber++;
//             isLocked = false;
//           });
//           _resetQuestionLocks();
//           startTimerOnQuestions();
//         } else {
//           _timer?.cancel();
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ResultsScreen(
//                 score: score,
//                 totalQuestions: widget.questionData.length,
//                 whichTopic: widget.topicType,
//               ),
//             ),
//           );
//         }
//       },
//       child: Text(
//         _questionNumber < widget.questionData.length
//             ? 'Next Question'
//             : 'Result',
//         style: Theme.of(context).textTheme.bodySmall!.copyWith(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//       ),
//     );
//   }
// }

// import 'dart:async';

// import 'package:flashcards_quiz/models/layout_questions_model.dart';
// import 'package:flashcards_quiz/views/results_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class QuizScreen extends StatefulWidget {
//   final String topicType;
//   final List<QuestionData> questionlenght;
//   final dynamic optionsList;
//   const QuizScreen(
//       {super.key,
//       required this.questionlenght,
//       required this.optionsList,
//       required this.topicType});

//   @override
//   State<QuizScreen> createState() => _QuizScreenState();
// }

// class _QuizScreenState extends State<QuizScreen> {
//   int questionTimerSeconds = 20;
//   Timer? _timer;
//   int _questionNumber = 1;
//   PageController _controller = PageController();
//   int score = 0;
//   bool isLocked = false;
//   List optionsLetters = ["A.", "B.", "C.", "D."];

//   void startTimerOnQuestions() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (mounted) {
//         setState(() {
//           if (questionTimerSeconds > 0) {
//             questionTimerSeconds--;
//           } else {
//             _timer?.cancel();
//             navigateToNewScreen();
//           }
//         });
//       }
//     });
//   }

//   void stopTime() {
//     _timer?.cancel();
//   }

//   void navigateToNewScreen() {
//     if (_questionNumber < widget.questionlenght.length) {
//       _controller.nextPage(
//         duration: const Duration(milliseconds: 600),
//         curve: Curves.easeInOut,
//       );
//       setState(() {
//         _questionNumber++;
//         isLocked = false;
//       });
//       _resetQuestionLocks();
//       startTimerOnQuestions();
//     } else {
//       _timer?.cancel();
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ResultsScreen(
//             score: score,
//             totalQuestions: widget.questionlenght.length,
//             whichTopic: widget.topicType,
//           ),
//         ),
//       );
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _controller = PageController(initialPage: 0);
//     _resetQuestionLocks();
//     startTimerOnQuestions();
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     const Color bgColor3 = Color(0xFF5170FD);
//     const Color bgColor = Color(0xFF4993FA);

//     return WillPopScope(
//       onWillPop: () {
//         Navigator.popUntil(context, (route) => route.isFirst);
//         return Future.value(false);
//       },
//       child: Scaffold(
//         backgroundColor: bgColor3,
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 10, right: 10),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       "${widget.topicType} Quiz",
//                       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.w400),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 14, bottom: 10),
//                   child: Row(
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         icon: const Icon(
//                           CupertinoIcons.clear,
//                           color: Colors.white,
//                           weight: 10,
//                         ),
//                       ),
//                       Expanded(
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(12),
//                           child: LinearProgressIndicator(
//                             minHeight: 20,
//                             value: 1 - (questionTimerSeconds / 20),
//                             backgroundColor: Colors.blue.shade100,
//                             color: Colors.blueGrey,
//                             valueColor: const AlwaysStoppedAnimation(bgColor),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.only(top: 12, left: 10, right: 10),
//                   width: MediaQuery.of(context).size.width * 0.90,
//                   height: MediaQuery.of(context).size.height * 0.75,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.24),
//                         blurRadius: 20.0,
//                         offset: const Offset(0.0, 10.0),
//                         spreadRadius: 10,
//                       )
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Center(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Question $_questionNumber/${widget.questionlenght.length}",
//                             style: TextStyle(
//                                 fontSize: 16, color: Colors.grey.shade500),
//                           ),
//                           Expanded(
//                             child: PageView.builder(
//                               controller: _controller,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemCount: widget.questionlenght.length,
//                               onPageChanged: (value) {
//                                 setState(() {
//                                   _questionNumber = value + 1;
//                                   isLocked = false;
//                                   _resetQuestionLocks();
//                                 });
//                               },
//                               itemBuilder: (context, index) {
//                                 final myquestions =
//                                     widget.questionlenght[index];
//                                 var optionsIndex = widget.optionsList[index];

//                                 return Column(
//                                   children: [
//                                     Text(
//                                       myquestions.question,
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .bodyLarge!
//                                           .copyWith(
//                                             fontSize: 18,
//                                           ),
//                                     ),
//                                     const SizedBox(
//                                       height: 25,
//                                     ),
//                                     Expanded(
//                                       child: ListView.builder(
//                                         itemCount: myquestions.options.length,
//                                         itemBuilder: (context, index) {
//                                           var color = Colors.grey.shade200;

//                                           var questionOption =
//                                               myquestions.options[index];
//                                           final letters = optionsLetters[index];

//                                           if (myquestions.isLocked) {
//                                             if (questionOption ==
//                                                 myquestions.options) {
//                                               color = questionOption.isCorrect
//                                                   ? Colors.green
//                                                   : Colors.red;
//                                             } else if (questionOption
//                                                 .isCorrect) {
//                                               color = Colors.green;
//                                             }
//                                           }
//                                           return InkWell(
//                                             onTap: () {
//                                               print(optionsIndex);
//                                               stopTime();
//                                               if (!myquestions.isLocked) {
//                                                 setState(() {
//                                                   myquestions.isLocked = true;
//                                                   myquestions.options =
//                                                       questionOption;
//                                                 });

//                                                 isLocked = myquestions.isLocked;
//                                                 if (myquestions
//                                                     .options
//                                                     .) {
//                                                   score++;
//                                                 }
//                                               }
//                                             },
//                                             child: Container(
//                                               height: 45,
//                                               padding: const EdgeInsets.all(10),
//                                               margin:
//                                                   const EdgeInsets.symmetric(
//                                                       vertical: 8),
//                                               decoration: BoxDecoration(
//                                                 border:
//                                                     Border.all(color: color),
//                                                 color: Colors.grey.shade100,
//                                                 borderRadius:
//                                                     const BorderRadius.all(
//                                                         Radius.circular(10)),
//                                               ),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   Text(
//                                                     "$letters ${questionOption.text}",
//                                                     style: const TextStyle(
//                                                         fontSize: 16),
//                                                   ),
//                                                   isLocked == true
//                                                       ? questionOption.isCorrect
//                                                           ? const Icon(
//                                                               Icons
//                                                                   .check_circle,
//                                                               color:
//                                                                   Colors.green,
//                                                             )
//                                                           : const Icon(
//                                                               Icons.cancel,
//                                                               color: Colors.red,
//                                                             )
//                                                       : const SizedBox.shrink()
//                                                 ],
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             ),
//                           ),
//                           isLocked
//                               ? buildElevatedButton()
//                               : const SizedBox.shrink(),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _resetQuestionLocks() {
//     for (var question in widget.questionlenght) {
//       question.isLocked = false;
//     }
//     questionTimerSeconds = 20;
//   }

//   ElevatedButton buildElevatedButton() {
//     //  const Color bgColor3 = Color(0xFF5170FD);
//     const Color cardColor = Color(0xFF4993FA);

//     return ElevatedButton(
//       style: ButtonStyle(
//         backgroundColor: MaterialStateProperty.all(cardColor),
//         fixedSize: MaterialStateProperty.all(
//           Size(MediaQuery.sizeOf(context).width * 0.80, 40),
//         ),
//         elevation: MaterialStateProperty.all(4),
//       ),
//       onPressed: () {
//         if (_questionNumber < widget.questionlenght.length) {
//           _controller.nextPage(
//             duration: const Duration(milliseconds: 800),
//             curve: Curves.easeInOut,
//           );
//           setState(() {
//             _questionNumber++;
//             isLocked = false;
//           });
//           _resetQuestionLocks();
//           startTimerOnQuestions();
//         } else {
//           _timer?.cancel();
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ResultsScreen(
//                 score: score,
//                 totalQuestions: widget.questionlenght.length,
//                 whichTopic: widget.topicType,
//               ),
//             ),
//           );
//         }
//       },
//       child: Text(
//         _questionNumber < widget.questionlenght.length
//             ? 'Next Question'
//             : 'Result',
//         style: Theme.of(context).textTheme.bodySmall!.copyWith(
//               color: Colors.white,
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flashcards_quiz/models/layout_questions_model.dart';
import 'package:flashcards_quiz/views/results_screen.dart';

class QuizScreen extends StatefulWidget {
  final String topicType;
  final List<QuestionData> questions;

  const QuizScreen({
    Key? key,
    required this.topicType,
    required this.questions,
  }) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int questionTimerSeconds = 20;
  Timer? _timer;
  int _questionNumber = 1;
  PageController _controller = PageController();
  int score = 0;
  bool isLocked = false;
  List<String> optionsLetters = ["A.", "B.", "C.", "D."];

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    _resetQuestionLocks();
    startTimerOnQuestions();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimerOnQuestions() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (questionTimerSeconds > 0) {
            questionTimerSeconds--;
          } else {
            _timer?.cancel();
            navigateToNewScreen();
          }
        });
      }
    });
  }

  void stopTime() {
    _timer?.cancel();
  }

  void navigateToNewScreen() {
    if (_questionNumber < widget.questions.length) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
      setState(() {
        _questionNumber++;
        isLocked = false;
      });
      _resetQuestionLocks();
      startTimerOnQuestions();
    } else {
      _timer?.cancel();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(
            score: score,
            totalQuestions: widget.questions.length,
            whichTopic: widget.topicType,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color bgColor3 = Color(0xFF5170FD);
    const Color bgColor = Color(0xFF4993FA);

    return WillPopScope(
      onWillPop: () {
        Navigator.popUntil(context, (route) => route.isFirst);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: bgColor3,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      "${widget.topicType} Quiz",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 14, bottom: 10),
                  child: Row(
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
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: LinearProgressIndicator(
                            minHeight: 20,
                            value: 1 - (questionTimerSeconds / 20),
                            backgroundColor: Colors.blue.shade100,
                            color: Colors.blueGrey,
                            valueColor: const AlwaysStoppedAnimation(bgColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 12, left: 10, right: 10),
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: MediaQuery.of(context).size.height * 0.75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.24),
                        blurRadius: 20.0,
                        offset: const Offset(0.0, 10.0),
                        spreadRadius: 10,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Question $_questionNumber/${widget.questions.length}",
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey.shade500),
                          ),
                          Expanded(
                            child: PageView.builder(
                              controller: _controller,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.questions.length,
                              onPageChanged: (value) {
                                setState(() {
                                  _questionNumber = value + 1;
                                  isLocked = false;
                                  _resetQuestionLocks();
                                });
                              },
                              itemBuilder: (context, index) {
                                final myQuestion = widget.questions[index];
                                return Column(
                                  children: [
                                    Text(
                                      myQuestion.question,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            fontSize: 18,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: myQuestion.options.length,
                                        itemBuilder: (context, index) {
                                          var color = Colors.grey.shade200;
                                          var questionOption =
                                              myQuestion.options[index];
                                          final letters = optionsLetters[index];
                                          if (myQuestion.isLocked) {
                                            if (questionOption.isCorrect) {
                                              color = Colors.green;
                                            } else if (questionOption ==
                                                myQuestion.options) {
                                              color = Colors.red;
                                            }
                                          }
                                          return InkWell(
                                            onTap: () {
                                              stopTime();
                                              if (!myQuestion.isLocked) {
                                                setState(() {
                                                  myQuestion.isLocked = true;
                                                });
                                                isLocked = myQuestion.isLocked;
                                                if (questionOption.isCorrect) {
                                                  score++;
                                                }
                                              }
                                            },
                                            child: Container(
                                              height: 45,
                                              padding: const EdgeInsets.all(10),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              decoration: BoxDecoration(
                                                border:
                                                    Border.all(color: color),
                                                color: Colors.grey.shade100,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "$letters ${questionOption.text}",
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  ),
                                                  isLocked == true
                                                      ? questionOption.isCorrect
                                                          ? const Icon(
                                                              Icons
                                                                  .check_circle,
                                                              color:
                                                                  Colors.green,
                                                            )
                                                          : const Icon(
                                                              Icons.cancel,
                                                              color: Colors.red,
                                                            )
                                                      : const SizedBox.shrink()
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          isLocked
                              ? buildElevatedButton()
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _resetQuestionLocks() {
    for (var question in widget.questions) {
      question.isLocked = false;
    }
    questionTimerSeconds = 20;
  }

  // ElevatedButton buildElevatedButton() {
  //   const Color cardColor = Color(0xFF4993FA);

  //   return ElevatedButton(
  //     style: ButtonStyle(
  //       backgroundColor: MaterialStateProperty.all(cardColor),
  //       fixedSize: MaterialStateProperty.all(
  //         Size(MediaQuery.size.width * 0.80, 40),
  //       ),
  //       elevation: MaterialStateProperty.all(4),
  //     ),
  //     onPressed: () {
  //       if (_questionNumber < widget.questions.length) {
  //         _controller.nextPage(
  //           duration: const Duration(milliseconds: 800),
  //           curve: Curves.easeInOut,
  //         );
  //         setState(() {
  //           _questionNumber++;
  //           isLocked = false;
  //         });
  //         _resetQuestionLocks();
  //         startTimerOnQuestions();
  //       } else {
  //         _timer?.cancel();
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => ResultsScreen(
  //               score: score,
  //               totalQuestions: widget.questions.length,
  //               whichTopic: widget.topicType,
  //             ),
  //           ),
  //         );
  //       }
  //     },
  //     child: Text(
  //       _questionNumber < widget.questions.length ? 'Next Question' : 'Result',
  //       style: Theme.of(context).textTheme.bodySmall!.copyWith(
  //             color: Colors.white,
  //             fontSize: 16,
  //             fontWeight: FontWeight.w500,
  //           ),
  //     ),
  //   );
  ElevatedButton buildElevatedButton() {
  const Color cardColor = Color(0xFF4993FA);

  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(cardColor),
      fixedSize: MaterialStateProperty.all(
        Size(MediaQuery.of(context).size.width * 0.80, 40),
      ),
      elevation: MaterialStateProperty.all(4),
    ),
    onPressed: () {
      if (_questionNumber < widget.questions.length) {
        _controller.nextPage(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
        setState(() {
          _questionNumber++;
          isLocked = false;
        });
        _resetQuestionLocks();
        startTimerOnQuestions();
      } else {
        _timer?.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsScreen(
              score: score,
              totalQuestions: widget.questions.length,
              whichTopic: widget.topicType,
            ),
          ),
        );
      }
    },
    child: Text(
      _questionNumber < widget.questions.length
          ? 'Next Question'
          : 'Result',
      style: Theme.of(context).textTheme.bodyText2!.copyWith(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
    ),
  );

  }
}
