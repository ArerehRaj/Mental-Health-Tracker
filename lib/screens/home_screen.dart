import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health_tracker_app/screens/quiz/quiz_screen.dart';

import '../widgets/grid_dashboard.dart';
import '../widgets/main_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isLoading = false;
  String _userName = '';
  int _userLevel = 0;
  final _userID = FirebaseAuth.instance.currentUser!.uid;

  void setUserName() async {
    final userDataDoc =
        await FirebaseFirestore.instance.collection('users').doc(_userID).get();
    final userData = userDataDoc.data() as Map;
    setState(() {
      _isLoading = false;
      _userName = userData['name'];
      _userLevel = int.parse(userData['user_level'].toString());
    });
  }

  Widget _getMindStateIcons(
    String imagePath,
    String text,
  ) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          imagePath,
          // fit: BoxFit.cover,
          height: 70,
          width: 90,
        ),
        const SizedBox(
          height: 10,
        ),
        FittedBox(
          child: Text(text),
        ),
      ]),
    );
  }

  Widget _getTaskCards(
    String title,
    String text,
    Color color,
    String actionText,
  ) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        color: color,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Alegreya',
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Alegreya',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FlatButton.icon(
                onPressed: () {},
                label: Text(
                  actionText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Alegreya',
                  ),
                ),
                icon: const Icon(
                  Icons.arrow_right,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    setUserName();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: const Icon(Icons.align_horizontal_left_rounded),
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
      drawer: MainDrawer(
        userName: _userName,
        userLevel: _userLevel,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurple.shade700,
              ),
            )
          : SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                width: deviceSize.width,
                height: deviceSize.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome Back, ',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Alegreya',
                          ),
                        ),
                        Text(
                          '$_userName!',
                          style: const TextStyle(
                            fontSize: 24,
                            fontFamily: 'Alegreya',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.0075,
                    ),
                    const Text(
                      'How are you feeling today?',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Alegreya',
                      ),
                    ),
                    SizedBox(
                      height: deviceSize.height * 0.0075,
                    ),
                    Container(
                      height: deviceSize.height * 0.2,
                      width: deviceSize.width * 0.9,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _getMindStateIcons(
                            'assets/images/happy-face.png',
                            'Happy',
                          ),
                          _getMindStateIcons(
                            'assets/images/fatigue.png',
                            'Tired',
                          ),
                          _getMindStateIcons(
                            'assets/images/angry.png',
                            'Angry',
                          ),
                          _getMindStateIcons(
                            'assets/images/meditation.png',
                            'Calm',
                          ),
                          _getMindStateIcons(
                            'assets/images/relaxing.png',
                            'Relax',
                          ),
                          _getMindStateIcons(
                            'assets/images/target.png',
                            'Focused',
                          ),
                          _getMindStateIcons(
                            'assets/images/tired.png',
                            'Sad',
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: deviceSize.height * 0.45,
                      width: deviceSize.width * 0.9,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          _getTaskCards(
                            'Music For You',
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry.',
                            Colors.pink.shade200,
                            'Listen Now',
                          ),
                          _getTaskCards(
                            'Meditation',
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry.',
                            Colors.green.shade300,
                            'Meditate Now',
                          ),
                          _getTaskCards(
                            'Tasks',
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry.',
                            Colors.blue.shade200,
                            'Checkout Now',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
