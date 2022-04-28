import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mental_health_tracker_app/screens/suggestions_results_screen.dart';

import '../constants.dart';

enum SuggestionsType { movie, songs }

class SuggestionsScreen extends StatefulWidget {
  SuggestionsScreen({Key? key}) : super(key: key);

  static const routeName = '/suggestions-screen';

  @override
  State<SuggestionsScreen> createState() => _SuggestionsScreenState();
}

class _SuggestionsScreenState extends State<SuggestionsScreen> {
  SuggestionsType _option = SuggestionsType.movie;
  final TextEditingController _input = TextEditingController();

  bool _isLoading = false;

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
          height: deviceSize.height * 0.75,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Suggestions',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Alegreya',
                  fontSize: 40,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ListTile(
                title: const Text('Songs'),
                leading: Radio(
                  value: SuggestionsType.songs,
                  groupValue: _option,
                  onChanged: (value) {
                    setState(() {
                      _option = value as SuggestionsType;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: const Text('Movies'),
                leading: Radio(
                  value: SuggestionsType.movie,
                  groupValue: _option,
                  onChanged: (value) {
                    setState(() {
                      _option = value as SuggestionsType;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  style: kBodyText.copyWith(
                    color: Colors.deepPurple.shade700,
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: _input,
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return 'Please enter a valid input';
                  //   }
                  //   return null;
                  // },
                  // onSaved: (value) {
                  //   _input = value.toString();
                  // },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    hintText: 'Enter type',
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
                height: 15,
              ),
              Container(
                height: 50,
                width: deviceSize.width,
                child: OutlineButton(
                  splashColor: Colors.deepPurple.shade700,
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    List<QueryDocumentSnapshot<Map<String, dynamic>>> docsList =
                        [];
                    var isMusic = false;
                    if (_option == SuggestionsType.movie) {
                      final suggestionsDocuments = await FirebaseFirestore
                          .instance
                          .collection('movie_database')
                          .where(
                        'genres',
                        arrayContainsAny: [
                          _input.text.toString(),
                        ],
                      ).get();
                      docsList = suggestionsDocuments.docs;
                      // print(suggestionsDocuments.docs[0].get('title'));
                    } else if (_option == SuggestionsType.songs) {
                      final suggestionsDocuments =
                          await FirebaseFirestore.instance
                              .collection('spotify_music_database')
                              .where(
                                'Energy',
                                isEqualTo: 45,
                              )
                              .get();
                      docsList = suggestionsDocuments.docs;
                      isMusic = true;
                    }

                    setState(() {
                      _isLoading = false;
                    });

                    print(isMusic);
                    // print(docsList);

                    Get.to(
                      () => SuggestionsResultsScreen(
                        resultsData: docsList,
                        isMusic: isMusic,
                      ),
                    );
                  },
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.deepPurple.shade700,
                          ),
                        )
                      : const Text(
                          'Check',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Alegreya',
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
