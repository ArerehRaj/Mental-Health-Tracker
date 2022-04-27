import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_health_tracker_app/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class FirstTimeForm extends StatefulWidget {
  FirstTimeForm({Key? key}) : super(key: key);

  @override
  State<FirstTimeForm> createState() => _FirstTimeFormState();
}

class _FirstTimeFormState extends State<FirstTimeForm> {
  int currentStep = 0;
  bool _isCompleted = false;
  final _formKey = GlobalKey<FormState>();
  int _userAge = 0;
  final _gender = [
    "Male",
    "Female",
    "Other",
  ];

  final _binaryOptions = [
    'Yes',
    'No',
  ];
  String? value;
  String? one;
  String? two;
  String? three;
  String? four;
  String? five;
  String? six;
  String? seven;
  String? eight;

  int score = 0;
  int userLevel = 1;

  // high score -> light qs (low level)
  // low score -> imp qs (high level)
  // 1- 16 -> 5
  // 17- 32 -> 4
  // 33- 48 -> 3
  // 49- 64 -> 2
  // 65- 80 -> 1

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            fontSize: 24,
            fontFamily: 'Alegreya',
          ),
        ),
      );

  List<Step> _getSteps(double height) => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const FittedBox(
              child: Text(
            'General',
            style: TextStyle(
              fontSize: 15,
            ),
          )),
          content: Container(
            height: height * 0.45,
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        style: kBodyText.copyWith(
                          color: Colors.deepPurple.shade700,
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a valid input';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userAge = int.parse(value.toString());
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15),
                          hintText: 'Age',
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
                    Container(
                      width: 300,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: const Text(
                            'Select Gender',
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'Alegreya',
                              color: Colors.black,
                            ),
                          ),
                          value: value,
                          isExpanded: true,
                          iconSize: 36,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          items: _gender.map(buildMenuItem).toList(),
                          onChanged: (value) => setState(() {
                            this.value = value as String;
                          }),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 300,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: CountryListPick(
                        theme: CountryTheme(
                          isShowFlag: true,
                          isShowTitle: true,
                          isShowCode: true,
                          isDownIcon: true,
                          showEnglishName: true,
                          labelColor: Colors.deepPurpleAccent.shade700,
                        ),
                        initialSelection: '+91',
                        onChanged: (code) {
                          print(code);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const FittedBox(
              child: Text(
            'Employement',
            style: TextStyle(
              fontSize: 15,
            ),
          )),
          content: Container(
            child: SingleChildScrollView(
              child: Container(
                // height: height,
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        width: 300,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: const Text(
                              'Are you Employed?',
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'Alegreya',
                                color: Colors.black,
                              ),
                            ),
                            value: one,
                            isExpanded: true,
                            iconSize: 36,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            items: _binaryOptions.map(buildMenuItem).toList(),
                            onChanged: (value) => setState(() {
                              one = value as String;
                              if (value.toString() == 'Yes') {
                                score = score + 8;
                              } else {
                                score = score + 3;
                              }
                            }),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 300,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: const FittedBox(
                              child: Text(
                                'Do you have a remote work?',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: 'Alegreya',
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            value: two,
                            isExpanded: true,
                            iconSize: 36,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            items: _binaryOptions.map(buildMenuItem).toList(),
                            onChanged: (value) => setState(() {
                              two = value as String;
                              if (value.toString() == 'Yes') {
                                score = score + 7;
                              } else {
                                score = score + 4;
                              }
                            }),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 300,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: const FittedBox(
                              child: Text(
                                'Do you Work in Tech Company?',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: 'Alegreya',
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            value: three,
                            isExpanded: true,
                            iconSize: 36,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            items: _binaryOptions.map(buildMenuItem).toList(),
                            onChanged: (value) => setState(() {
                              three = value as String;
                              if (value.toString() == 'Yes') {
                                score = score + 7;
                              } else {
                                score = score + 5;
                              }
                            }),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 300,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: const FittedBox(
                              child: Text(
                                'Are you provided with any Care options?',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: 'Alegreya',
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            value: four,
                            isExpanded: true,
                            iconSize: 36,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            items: _binaryOptions.map(buildMenuItem).toList(),
                            onChanged: (value) => setState(() {
                              four = value as String;
                              if (value.toString() == 'Yes') {
                                score = score + 10;
                              } else {
                                score = score + 2;
                              }
                            }),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 300,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: const Text(
                              'Do you have leave options?',
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'Alegreya',
                                color: Colors.black,
                              ),
                            ),
                            value: five,
                            isExpanded: true,
                            iconSize: 36,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            items: _binaryOptions.map(buildMenuItem).toList(),
                            onChanged: (value) => setState(() {
                              five = value as String;
                              if (value.toString() == 'Yes') {
                                score = score + 10;
                              } else {
                                score = score + 1;
                              }
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const FittedBox(
              child: Text(
            'Mind',
            style: TextStyle(
              fontSize: 15,
            ),
          )),
          content: Container(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: 300,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: const FittedBox(
                            child: Text(
                              'Have you recieved any Previous Treatment?',
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'Alegreya',
                                color: Colors.black,
                              ),
                            ),
                          ),
                          value: six,
                          isExpanded: true,
                          iconSize: 36,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          items: _binaryOptions.map(buildMenuItem).toList(),
                          onChanged: (value) => setState(() {
                            six = value as String;
                            if (value.toString() == 'Yes') {
                              score = score + 8;
                            } else {
                              score = score + 4;
                            }
                          }),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 300,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: const FittedBox(
                            child: Text(
                              'Is there any Work Interference?',
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'Alegreya',
                                color: Colors.black,
                              ),
                            ),
                          ),
                          value: seven,
                          isExpanded: true,
                          iconSize: 36,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          items: _binaryOptions.map(buildMenuItem).toList(),
                          onChanged: (value) => setState(() {
                            seven = value as String;
                            if (value.toString() == 'Yes') {
                              score = score + 4;
                            } else {
                              score = score + 9;
                            }
                          }),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 300,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: const FittedBox(
                            child: Text(
                              'Do you have any Family History?',
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'Alegreya',
                                color: Colors.black,
                              ),
                            ),
                          ),
                          value: eight,
                          isExpanded: true,
                          iconSize: 36,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          items: _binaryOptions.map(buildMenuItem).toList(),
                          onChanged: (value) => setState(() {
                            eight = value as String;
                            if (value.toString() == 'Yes') {
                              score = score + 9;
                            } else {
                              score = score + 3;
                            }
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ];

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
          height: deviceSize.height,
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.deepPurple.shade700,
              ),
            ),
            child: Stepper(
              type: StepperType.horizontal,
              currentStep: currentStep,
              steps: _getSteps(deviceSize.height),
              onStepTapped: (step) => setState(() {
                currentStep = step;
              }),
              onStepContinue: () async {
                final lastStep =
                    currentStep == _getSteps(deviceSize.height).length - 1;
                if (lastStep) {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('first_time', false);
                  setState(() {
                    _isCompleted = true;
                  });

                  if (score >= 1 && score <= 16) {
                    userLevel = 5;
                  } else if (score >= 17 && score <= 32) {
                    userLevel = 4;
                  } else if (score >= 33 && score <= 48) {
                    userLevel = 3;
                  } else if (score >= 49 && score <= 64) {
                    userLevel = 2;
                  } else if (score >= 65 && score <= 80) {
                    userLevel = 1;
                  }

                  final _userID = FirebaseAuth.instance.currentUser!.uid;

                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(_userID)
                      .update(
                    {
                      'user_level': userLevel,
                    },
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Thanks for filling out the Form.'),
                      backgroundColor: Colors.green.shade300,
                    ),
                  );

                  Get.to(() => const HomeScreen());
                } else {
                  setState(() {
                    currentStep += 1;
                  });
                }
              },
              onStepCancel: () {
                currentStep == 0
                    ? null
                    : setState(() {
                        currentStep -= 1;
                      });
              },
              controlsBuilder: (context, details) {
                final lastStep =
                    currentStep == _getSteps(deviceSize.height).length - 1;
                return Container(
                  margin: const EdgeInsets.only(
                    top: 50,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          child: Text(lastStep ? 'CONFIRM' : 'NEXT'),
                          onPressed: details.onStepContinue,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      if (currentStep != 0)
                        Expanded(
                          child: ElevatedButton(
                            child: const Text('BACK'),
                            onPressed: details.onStepCancel,
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
