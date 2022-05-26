import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mental_health_tracker_app/controllers/question_controller.dart';
import 'package:mental_health_tracker_app/screens/feedback_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    Key? key,
    this.testResult,
    this.testScore,
    this.imageUrl,
  }) : super(key: key);

  final testScore;
  final testResult;
  final imageUrl;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    QuestionController _qnController = Get.put(QuestionController());
    int userlevel = _qnController.userLevel;
    var usermood = "";
    if (userlevel == 1) {
      usermood = "Happy and relaxed";
    } else if (userlevel == 2) {
      usermood = "Healthy Mental State";
    } else if (userlevel == 3) {
      usermood = "A little stressed";
    } else if (userlevel == 4) {
      usermood = "Stressed";
    } else if (userlevel == 5) {
      usermood = "Depressed";
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
        child: Container(
          width: deviceSize.width,
          height: deviceSize.height * 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Your Mental Health Score',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Alegreya',
                  fontSize: 32,
                ),
              ),
              Text(
                'For ' + DateFormat.yMMMd().format(DateTime.now()),
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontFamily: 'Alegreya',
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: deviceSize.height * 0.05,
              ),
              CircleAvatar(
                backgroundColor: Colors.deepPurple.shade700.withOpacity(0.8),
                radius: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _qnController.userScore.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Alegreya',
                        fontSize: 35,
                      ),
                    ),
                    Text(
                      usermood,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Alegreya',
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: deviceSize.height * 0.05,
              ),
              const CircleAvatar(
                radius: 65.0,
                backgroundImage: AssetImage('assets/images/happy-face.png'),
                backgroundColor: Colors.transparent,
              ),
              SizedBox(
                height: deviceSize.height * 0.05,
              ),
              Container(
                height: 50,
                width: deviceSize.width * 0.9,
                child: OutlineButton(
                  splashColor: Colors.deepPurple.shade700,
                  onPressed: () {
                    Get.to(() => FeedbackScreen());
                  },
                  child: const Text(
                    'Feedback',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Alegreya',
                    ),
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
