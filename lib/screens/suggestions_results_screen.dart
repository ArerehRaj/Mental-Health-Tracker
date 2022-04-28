import 'package:flutter/material.dart';

class SuggestionsResultsScreen extends StatelessWidget {
  SuggestionsResultsScreen({
    Key? key,
    required this.resultsData,
    required this.isMusic,
  }) : super(key: key);
  static const routeName = '/suggestions-results-screen';

  final List resultsData;
  final bool isMusic;

  Widget _getCards(
    String title,
    String rating,
    String year,
  ) {
    return Card(
      margin: const EdgeInsets.all(10),
      color: Colors.green[100],
      shadowColor: Colors.blueGrey,
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(
              Icons.album,
              color: Colors.deepPurple.shade700,
              size: 45,
            ),
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Alegreya',
              ),
            ),
            subtitle:
                isMusic ? Text('Artist: ' + rating) : Text('Rating: ' + rating),
            trailing: Text('Year ' + year),
          ),
        ],
      ),
    );
  }

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
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              if (isMusic) {
                return _getCards(
                  resultsData[index].get('Title').toString(),
                  resultsData[index].get('Artist').toString(),
                  resultsData[index].get('Year').toString(),
                );
              } else {
                return _getCards(
                  resultsData[index].get('title').toString(),
                  resultsData[index].get('rating').toString(),
                  resultsData[index].get('year').toString(),
                );
              }
            },
            itemCount: resultsData.length,
          ),
        ),
      ),
    );
  }
}
