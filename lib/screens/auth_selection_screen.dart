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
      if (isLogin) {
        print('HERE');
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set(
          {
            'name': name,
            'email': email,
            'phone': phone,
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
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Flexible(
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: const Image(
                          image:
                              AssetImage('assets/images/team_illustration.png'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Enterprise team\ncollaboration.",
                      style: kHeadline,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: const Text(
                        "Bring together your files, your tools, project and people.Including a new mobile and desktop application.",
                        style: kBodyText,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: MyTextButton(
                        bgColor: Colors.white,
                        buttonName: 'Register',
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            RegisterPage.routeName,
                            arguments: {
                              'auth_function': _submitAuthForm,
                            },
                          );
                        },
                        textColor: Colors.black87,
                      ),
                    ),
                    Expanded(
                      child: MyTextButton(
                        bgColor: Colors.transparent,
                        buttonName: 'Sign In',
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            LoginScreen.routeName,
                            arguments: {
                              'auth_function': _submitAuthForm,
                            },
                          );
                        },
                        textColor: Colors.white,
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
