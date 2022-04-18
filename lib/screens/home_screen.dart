import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
        child: FlatButton(
          onPressed: () {
            print('fsd');
            FirebaseAuth.instance.signOut();
          },
          child: const Text('Home Screen'),
        ),
      ),
    );
  }
}
