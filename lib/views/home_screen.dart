import 'dart:io';

import 'package:flashcards_quiz/main.dart';
import 'package:flashcards_quiz/notifiers/TitleNotifier.dart';
import 'package:flashcards_quiz/views/flashcard_screen.dart';
import 'package:flashcards_quiz/views/signup_screen.dart';
import 'package:flashcards_quiz/views/widgetview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quickalert/quickalert.dart';
import 'package:widget_state_notifier/widget_state_notifier.dart';

import 'categoryview.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements TitleImplement {
  @override
  void initState() {
    super.initState();

    TitleNotifier().start(this);
  }

  @override
  BuildContext? get getContext => context;

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
                    IconButton(
                        onPressed: () {
                          showCustomProgressBar(context);
                          SupabaseConfig.client.auth.signOut().then((value) {
                            closeCustomProgressBar(context);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignupScreen()),
                                (route) => false);
                          });
                        },
                        icon: const Icon(
                          Icons.logout_outlined,
                          color: Colors.red,
                          size: 24,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
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
                WidgetStateConsumer(
                    widgetStateNotifier: TitleNotifier().stateNotifier,
                    widgetStateBuilder: (context, snapshot) {
                      if (snapshot == null) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Center(
                            child: Platform.isIOS
                                ? Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: const CupertinoActivityIndicator(
                                      color: Colors.white,
                                      radius: 35 / 2,
                                    ))
                                : const CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                          ),
                        );
                      }
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.85,
                        ),
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot?.length ?? 0,
                        itemBuilder: (context, index) {
                          final topicsName = snapshot![index];
                          final questionNotifier = TitleNotifier()
                              .getThisQuestionNotifier(topicsName)!;

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewCard(
                                    topicName: topicsName,
                                    questionNotifier: questionNotifier,
                                    // questionData: topicsData.topicQuestions,
                                  ),
                                ),
                              );
                              print(topicsName);
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.ac_unit_sharp,
                                              color: Colors.white,
                                              size: 55,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              topicsName,
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
                                                      'lets check the ${topicsName} Questions so that we can Edit & Delete & Create!',
                                                  title: topicsName,
                                                  confirmBtnText: "Okay",
                                                  confirmBtnColor: bgColor3,
                                                  onConfirmBtnTap: () {
                                                    Navigator.pop(context);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            WidgetView(
                                                                topicsName,
                                                                questionNotifier),
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
                      );
                    }),
              ],
            ),
          ),
        ),
        floatingActionButton: (isAdmin)
            ? FloatingActionButton(
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
              )
            : const SizedBox(),
      );
    });
  }
}
