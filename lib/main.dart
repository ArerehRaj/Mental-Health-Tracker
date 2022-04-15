import 'package:flutter/material.dart';
import './screens/auth_selection_screen.dart';
import './screens/login_screen.dart';
import './screens/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mental Health Tracker',
      theme: ThemeData(
        fontFamily: 'Raleway',
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => const AuthSelectionScreen(),
        LoginScreen.routeName: (ctx) => const LoginScreen(),
        RegisterPage.routeName: (ctx) => RegisterPage(),
      },
    );
  }
}
