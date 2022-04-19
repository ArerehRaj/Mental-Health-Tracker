import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mental_health_tracker_app/screens/quiz/quiz_screen.dart';

import './screens/auth_selection_screen.dart';
import './screens/login_screen.dart';
import './screens/register.dart';
import './screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

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
            return const HomeScreen();
          }
          return AuthSelectionScreen();
        },
      ),
      theme: ThemeData(
        fontFamily: 'Raleway',
      ),
      // initialRoute: '/',
      routes: {
        // '/': (ctx) => AuthSelectionScreen(),
        LoginScreen.routeName: (ctx) => const LoginScreen(),
        RegisterPage.routeName: (ctx) => RegisterPage(),
        HomeScreen.routeName: (ctx) => const HomeScreen(),
        QuizScreen.routeName: (ctx) => QuizScreen(),
      },
    );
  }
}
