import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../constants.dart';
import 'home_screen.dart';

class FeedbackScreen extends StatefulWidget {
  FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  Future<void> submitFeedback() async {
    await FirebaseFirestore.instance.collection('feedback').add(
      {
        'user_id': FirebaseAuth.instance.currentUser!.uid,
        'rating': _rating,
        'note': _note,
        'question_one': {
          'Did you answer all the questions truthfully?': {
            'like': _likeOne,
            'dis_like': _dislikeOne,
          },
        },
        'question_two': {
          'Were the questions related to your current mental state?': {
            'like': _likeTwo,
            'dis_like': _dislikeTwo,
          },
        },
        'question_three': {
          'Did the suggestions help in making your mood lighter?': {
            'like': _likeThree,
            'dis_like': _dislikeThree,
          },
        },
        'question_four': {
          'Were the movie/song recommendations as per your liking?': {
            'like': _likeFour,
            'dis_like': _dislikeFour,
          },
        },
      },
    );
  }

  Widget _image(String asset) {
    return Image.asset(
      asset,
      height: 30.0,
      width: 30.0,
      color: Colors.deepPurple.shade700.withOpacity(0.9),
    );
  }

  var _likeOne = false;

  var _dislikeOne = false;

  var _likeTwo = false;

  var _dislikeTwo = false;

  var _likeThree = false;

  var _dislikeThree = false;

  var _likeFour = false;

  var _dislikeFour = false;

  var _rating = 0.0;

  var _note = '';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            margin: const EdgeInsets.all(10),
            child: IconButton(
              icon: const Icon(Icons.highlight_remove),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          )
        ],
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
          height: deviceSize.height * 0.9,
          margin: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                elevation: 10,
                shadowColor: Colors.grey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'How was your Experience?',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Alegreya',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: deviceSize.width * 0.75,
                      height: 50,
                      child: RatingBar(
                        initialRating: 3,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ratingWidget: RatingWidget(
                          full: _image('assets/images/heart.png'),
                          half: _image('assets/images/heart_half.png'),
                          empty: _image('assets/images/heart_border.png'),
                        ),
                        itemPadding: const EdgeInsets.symmetric(
                          horizontal: 4.0,
                        ),
                        onRatingUpdate: (rating) {
                          _rating = rating;
                          print(rating);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                child: SizedBox(
                  height: 70,
                  width: deviceSize.width,
                  child: ListTile(
                    title: const Text(
                      'Did you answer all the questions truthfully?',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Alegreya',
                        fontSize: 20,
                      ),
                    ),
                    trailing: SizedBox(
                      height: 40,
                      width: deviceSize.width * 0.25,
                      child: Row(children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (_dislikeOne) {
                                _dislikeOne = !_dislikeOne;
                              }
                              _likeOne = !_likeOne;
                            });
                          },
                          icon: Icon(
                            _likeOne
                                ? Icons.thumb_up_alt
                                : Icons.thumb_up_alt_outlined,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (_likeOne) {
                                _likeOne = !_likeOne;
                              }
                              _dislikeOne = !_dislikeOne;
                            });
                          },
                          icon: Icon(
                            _dislikeOne
                                ? Icons.thumb_down_alt
                                : Icons.thumb_down_alt_outlined,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                child: SizedBox(
                  height: 85,
                  width: deviceSize.width,
                  child: ListTile(
                    title: const Text(
                      'Were the questions related to your current mental state?',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Alegreya',
                        fontSize: 20,
                      ),
                    ),
                    trailing: SizedBox(
                      height: 40,
                      width: deviceSize.width * 0.25,
                      child: Row(children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (_dislikeTwo) {
                                _dislikeTwo = !_dislikeTwo;
                              }
                              _likeTwo = !_likeTwo;
                            });
                          },
                          icon: Icon(
                            _likeTwo
                                ? Icons.thumb_up_alt
                                : Icons.thumb_up_alt_outlined,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (_likeTwo) {
                                _likeTwo = !_likeTwo;
                              }
                              _dislikeTwo = !_dislikeTwo;
                            });
                          },
                          icon: Icon(
                            _dislikeTwo
                                ? Icons.thumb_down_alt
                                : Icons.thumb_down_alt_outlined,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                child: SizedBox(
                  height: 70,
                  width: deviceSize.width,
                  child: ListTile(
                    title: const Text(
                      'Did the suggestions help in making your mood lighter?',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Alegreya',
                        fontSize: 20,
                      ),
                    ),
                    trailing: SizedBox(
                      height: 40,
                      width: deviceSize.width * 0.25,
                      child: Row(children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (_dislikeThree) {
                                _dislikeThree = !_dislikeThree;
                              }
                              _likeThree = !_likeThree;
                            });
                          },
                          icon: Icon(
                            _likeThree
                                ? Icons.thumb_up_alt
                                : Icons.thumb_up_alt_outlined,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (_likeThree) {
                                _likeThree = !_likeThree;
                              }
                              _dislikeThree = !_dislikeThree;
                            });
                          },
                          icon: Icon(
                            _dislikeThree
                                ? Icons.thumb_down_alt
                                : Icons.thumb_down_alt_outlined,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                child: SizedBox(
                  height: 85,
                  width: deviceSize.width,
                  child: ListTile(
                    title: const Text(
                      'Were the movie/song recommendations as per your liking?',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Alegreya',
                        fontSize: 20,
                      ),
                    ),
                    trailing: SizedBox(
                      height: 40,
                      width: deviceSize.width * 0.25,
                      child: Row(children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (_dislikeFour) {
                                _dislikeFour = !_dislikeFour;
                              }
                              _likeFour = !_likeFour;
                            });
                          },
                          icon: Icon(
                            _likeFour
                                ? Icons.thumb_up_alt
                                : Icons.thumb_up_alt_outlined,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (_likeFour) {
                                _likeFour = !_likeFour;
                              }
                              _dislikeFour = !_dislikeFour;
                            });
                          },
                          icon: Icon(
                            _dislikeFour
                                ? Icons.thumb_down_alt
                                : Icons.thumb_down_alt_outlined,
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  style: kBodyText.copyWith(
                    color: Colors.deepPurple.shade700,
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a valid input';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    print(value);
                    _note = value.toString();
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    hintText: 'Add a note',
                    hintStyle: kBodyText,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.deepPurple.shade700,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: OutlineButton(
                  splashColor: Colors.deepPurple.shade700,
                  onPressed: () async {
                    await submitFeedback();
                    Future.delayed(const Duration(milliseconds: 50));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                            'Thanks for filling out the Feedback Form.'),
                        backgroundColor: Colors.green.shade300,
                      ),
                    );

                    Get.to(() => const HomeScreen());
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Alegreya',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
