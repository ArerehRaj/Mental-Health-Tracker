import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mental_health_tracker_app/screens/home_screen.dart';

import 'package:mental_health_tracker_app/screens/login_screen.dart';
import 'package:mental_health_tracker_app/screens/register.dart';
import '../constants.dart';
import '../widgets/text_button.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthSelectionScreen extends StatelessWidget {
  AuthSelectionScreen({Key? key}) : super(key: key);

  final _auth = FirebaseAuth.instance;

  void _submitAuthForm(
    String name,
    String password,
    String email,
    String phone,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult;
    try {
      final prefs = await SharedPreferences.getInstance();
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        await prefs.setBool('first_time', false);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        await prefs.setBool('first_time', true);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set(
          {
            'name': name,
            'email': email,
            'phone': phone,
            'user_level': 0,
          },
        );
      }
    } on PlatformException catch (error) {
      var message = 'An error occured, Please check your credentials.';
      if (error.message != null) {
        message = error.message.toString();
      }

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    }
    Navigator.of(ctx).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: const Image(
                          image: AssetImage('assets/images/app_logo.png'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "HappyMent\nFor You.",
                      style: kHeadline,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
                        "Mental illness is not a personal failure\n Be brave and it will pass by.",
                        style: kBodyText,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        child: OutlineButton(
                          splashColor: Colors.deepPurple.shade700,
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              RegisterPage.routeName,
                              arguments: {
                                'auth_function': _submitAuthForm,
                              },
                            );
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Alegreya',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.05,
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        child: OutlineButton(
                          splashColor: Colors.deepPurple.shade700,
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              LoginScreen.routeName,
                              arguments: {
                                'auth_function': _submitAuthForm,
                              },
                            );
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Alegreya',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
