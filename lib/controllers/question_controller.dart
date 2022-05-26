import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';
import '/models/Questions.dart';
import '/screens/result_screen.dart';

// We use get package for our state management

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  // Lets animated our progress bar

  late AnimationController _animationController;
  late Animation _animation;
  // so that we can access our animation outside
  Animation get animation => this._animation;

  late PageController _pageController;
  PageController get pageController => this._pageController;

  int userLevel = 1;
  final List<FirebaseQuestion> _firebaseQuestions =
      FirebaseQuestion.data.map((questionf) {
    return FirebaseQuestion(
      question: questionf.get('question'),
      falseScore: questionf.get('is_mcq') ? 0 : questionf.get('false'),
      options: questionf.get('is_mcq')
          ? [
              questionf.get('option_1'),
              questionf.get('option_2'),
              questionf.get('option_3'),
              questionf.get('option_4'),
            ]
          : [],
      trueScore: questionf.get('is_mcq') ? 10 : questionf.get('true'),
      isMcq: questionf.get('is_mcq'),
      level: questionf.get('level'),
    );
  }).toList();

  List<FirebaseQuestion> get firebaseQuestions => this._firebaseQuestions;

  final List<Question> _questions = sample_data
      .map(
        (question) => Question(
            id: question['id'],
            question: question['question'],
            options: question['options'],
            answer: question['answer_index']),
      )
      .toList();
  List<Question> get questions => this._questions;

  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  // late int _correctAns;
  // int get correctAns => this._correctAns;

  late int _selectedAns;
  int get selectedAns => this._selectedAns;

  late int _userScore = 0;
  int get userScore => this._userScore;

  // for more about obs please check documentation
  final RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  // int _numOfCorrectAns = 0;
  // int get numOfCorrectAns => this._numOfCorrectAns;

  // called immediately after the widget is allocated memory
  @override
  void onInit() {
    // Our animation duration is 60 s
    // so our plan is to fill the progress bar within 60s
    _animationController =
        AnimationController(duration: Duration(seconds: 60), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        // update like setState
        update();
      });

    // start our animation
    // Once 60s is completed go to the next qn
    _animationController.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    super.onInit();
  }

  // // called just before the Controller is deleted from memory
  @override
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
    _questionNumber.value = 1;
  }

  Future<void> checkAns(
      FirebaseQuestion question, int selectedIndex, bool isMcq) async {
    // because once user press any option then it will run
    _isAnswered = true;
    // _correctAns = question.answer;
    _selectedAns = selectedIndex;
    if (isMcq) {
      _userScore +=
          int.parse(question.options[selectedIndex]['score'].toString());
    } else {
      if (selectedIndex == 0) {
        _userScore += question.trueScore;
      } else {
        _userScore += question.falseScore;
      }
    }

    // if (_correctAns == _selectedAns) _numOfCorrectAns++;

    // It will stop the counter
    _animationController.stop();
    print('User score ' + _userScore.toString());
    if (_userScore >= 1 && _userScore <= 16) {
      userLevel = 5;
    } else if (_userScore >= 17 && _userScore <= 32) {
      userLevel = 4;
    } else if (_userScore >= 33 && _userScore <= 48) {
      userLevel = 3;
    } else if (_userScore >= 49 && _userScore <= 64) {
      userLevel = 2;
    } else if (_userScore >= 65) {
      userLevel = 1;
    }
    update();
    final _userID = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(_userID).update(
      {
        'user_level': userLevel,
      },
    );

    // Once user select an ans after 3s it will go to the next qn
    Future.delayed(Duration(seconds: 3), () {
      print('1');
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != _firebaseQuestions.length) {
      print('2');
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);

      // Reset the counter
      _animationController.reset();

      // Then start it again
      // Once timer is finish go to the next qn
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      // Get package provide us simple way to naviigate another page
      print('3');
      Get.to(() => ResultScreen());
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
