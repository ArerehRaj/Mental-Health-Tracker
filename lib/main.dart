import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mental_health_tracker_app/screens/first_time_form.dart';
import 'package:mental_health_tracker_app/screens/quiz/quiz_screen.dart';
import 'package:mental_health_tracker_app/screens/suggestions_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './screens/auth_selection_screen.dart';
import './screens/login_screen.dart';
import './screens/register.dart';
import './screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

final _userID = FirebaseAuth.instance.currentUser!.uid;
var prefs;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mental Health Tracker',
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Text('Connecting...');
          }
          if (userSnapshot.hasData) {
            if (prefs.containsKey('first_time') &&
                prefs.getBool('first_time')) {
              return FirstTimeForm();
            } else {
              return const HomeScreen();
            }
          }
          return AuthSelectionScreen();
        },
      ),
      theme: ThemeData(
        fontFamily: 'Raleway',
      ),
      routes: {
        LoginScreen.routeName: (ctx) => const LoginScreen(),
        RegisterPage.routeName: (ctx) => RegisterPage(),
        HomeScreen.routeName: (ctx) => const HomeScreen(),
        QuizScreen.routeName: (ctx) => QuizScreen(),
        SuggestionsScreen.routeName: (ctx) => SuggestionsScreen(),
      },
    );
  }
}
