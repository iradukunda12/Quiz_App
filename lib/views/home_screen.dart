import 'package:flashcards_quiz/main.dart';
import 'package:flashcards_quiz/models/flutter_topics_model.dart';
import 'package:flashcards_quiz/views/flashcard_screen.dart';
import 'package:flashcards_quiz/views/navigation.dart';
import 'package:flashcards_quiz/views/signup_screen.dart';
import 'package:flashcards_quiz/views/statemanagement.dart';
import 'package:flashcards_quiz/views/widgetview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quickalert/quickalert.dart';

import 'package:flashcards_quiz/views/results_screen.dart';

import 'categoryview.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFF4993FA);
    const Color bgColor3 = Color(0xFF5170FD);
    return Builder(builder: (context) {
      return Scaffold(
        backgroundColor: bgColor3,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 0, left: 15, right: 15),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: (){
                      showCustomProgressBar(context);
                      SupabaseConfig.client.auth.signOut().then((value){
                        closeCustomProgressBar(context);
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> SignupScreen()),(a) => false);
                      });

                    }, icon: const Icon(Icons.logout_outlined,color: Colors.red,size: 24,))
                  ],
                ),
                const SizedBox(height: 16,),
                Container(
                  decoration: BoxDecoration(
                    color: bgColor3,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.24),
                        blurRadius: 20.0,
                        offset: const Offset(0.0, 10.0),
                        spreadRadius: -10,
                        blurStyle: BlurStyle.outer,
                      )
                    ],
                  ),
                  child: Image.asset("assets/dash.png"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Flutter ",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontSize: 21,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        for (var i = 0; i < "Quiz!!!".length; i++) ...[
                          TextSpan(
                            text: "Quiz!!!"[i],
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  fontSize: 21 + i.toDouble(),
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.85,
                  ),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: flutterTopicsList.length,
                  itemBuilder: (context, index) {
                    final topicsData = flutterTopicsList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewCard(
                              topicName: topicsData.topicName, questionData: topicsData.topicQuestions,
                            ),
                          ),
                        );
                        print(topicsData.topicName);
                      },
                      child: Card(
                        color: bgColor,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Stack(
                            children: [
                              Positioned.fill(
                                top: 16,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        topicsData.topicIcon,
                                        color: Colors.white,
                                        size: 55,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        topicsData.topicName,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                            ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              if (isAdmin)
                                Positioned(
                                  top: 10,
                                  right: 0,
                                  left: 8,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.success,
                                            text:
                                                'lets check the ${topicsData.topicName} Questions so that we can Edit & Delete & Create!',
                                            title: topicsData.topicName,
                                            confirmBtnText: "Okay",
                                            confirmBtnColor: bgColor3,
                                            onConfirmBtnTap: () {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      WidgetView(topicsData.topicName),
                                                ),
                                              );
                                              print("Hello world it's ");
                                            },
                                          );
                                        },
                                        child: const Icon(
                                          Icons.menu,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: (isAdmin) ? FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryView(),
              ),
            );
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ) : const SizedBox(),
      );
    });
  }
}
