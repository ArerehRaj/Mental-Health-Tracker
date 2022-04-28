import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/question_controller.dart';

import 'components/body.dart';

class QuizScreen extends StatelessWidget {
  static const routeName = "/quiz_screen";
  final quizQuestions;

  QuizScreen({
    this.quizQuestions,
  });

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          FlatButton(
            onPressed: _controller.nextQuestion,
            child: const Text(
              "Skip",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Alegreya',
                fontSize: 20,
              ),
            ),
          ),
        ],
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Row(
          children: [
            Image.asset(
              'assets/images/app_logo.png',
              fit: BoxFit.cover,
              height: 30,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'HappyMent',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Alegreya',
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
      body: const Body(
        key: null,
      ),
    );
  }
}
