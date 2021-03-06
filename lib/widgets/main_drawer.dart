import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_health_tracker_app/screens/feedback_screen.dart';
import 'package:mental_health_tracker_app/screens/quiz/quiz_screen.dart';
import 'package:mental_health_tracker_app/screens/suggestions_screen.dart';
import 'package:mental_health_tracker_app/screens/user_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({
    Key? key,
    required this.userName,
    required this.userLevel,
  }) : super(key: key);

  final userName;
  final userLevel;

  Widget buildListTile(String title, IconData icon, VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Alegreya',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Drawer(
      child: Column(
        children: [
          Container(
            height: deviceSize.height * 0.25,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Colors.deepPurple.shade700,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/happy-face.png',
                  height: 70,
                  width: 70,
                ),
                const Text(
                  'HappyMent For You!',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: Image.asset(
                        'assets/images/relaxing.png',
                        height: 65,
                        width: 65,
                      ),
                      backgroundColor: Colors.grey,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      userName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Alegreya',
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          buildListTile(
            'Take a Test',
            Icons.spellcheck_rounded,
            () async {
              final questionsDocuments = await FirebaseFirestore.instance
                  .collection('questionnaire')
                  .where('level', isEqualTo: userLevel)
                  .get();
              // print(questionsDocuments.docs[0].get('question'));
              Get.to(
                () => QuizScreen(
                  quizQuestions: questionsDocuments.docs,
                ),
              );
            },
          ),
          buildListTile(
            'Suggestions',
            Icons.health_and_safety_sharp,
            () {
              // TMDBApi tmdb = new TMDBApi('YOUR_API_KEY_HERE');
              Get.to(() => SuggestionsScreen());
            },
          ),
          buildListTile(
            'Feedback',
            Icons.feedback_outlined,
            () {
              Get.to(() => FeedbackScreen());
            },
          ),
          buildListTile(
            'Settings',
            Icons.settings,
            () {
              // Navigator.of(context)
              // .pushReplacementNamed(FiltersScreen.routeName);

              Get.to(() => UserProfileScreen(
                    userName: userName,
                  ));
            },
          ),
          buildListTile(
            'Logout',
            Icons.logout,
            () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('first_time', false);
              print('here');
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
