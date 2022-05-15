import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../constants.dart';

class FeedbackScreen extends StatefulWidget {
  FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
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

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
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
                  height: 50,
                  width: deviceSize.width,
                  child: ListTile(
                    title: const Text(
                      'Questions Quality',
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
                  height: 50,
                  width: deviceSize.width,
                  child: ListTile(
                    title: const Text(
                      'App features',
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
                  height: 50,
                  width: deviceSize.width,
                  child: ListTile(
                    title: const Text(
                      'XYZ',
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
                  height: 50,
                  width: deviceSize.width,
                  child: ListTile(
                    title: const Text(
                      'PQR',
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
                  onSaved: (value) {
                    // _userEmail = value.toString();
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
                  onPressed: () {
                    // _trySubmit(authFunction);
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
