import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_health_tracker_app/screens/quiz/quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            FlatButton(
              onPressed: () {
                print('fsd');
                FirebaseAuth.instance.signOut();
              },
              child: const Text('Home Screen'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed(QuizScreen.routeName);
              },
              child: const Text('Quiz Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
