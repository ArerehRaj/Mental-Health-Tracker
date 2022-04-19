class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question(
      {required this.id,
      required this.question,
      required this.answer,
      required this.options});
}

const List sample_data = [
  {
    "id": 1,
    "question": "How was your day?",
    "options": ['Excellent', 'Very Good', 'Good', 'Decent', 'Bad'],
    "answer_index": 2,
  },
  {
    "id": 2,
    "question": "How many people did you interact with today?",
    "options": ['10-15', '20-25', '25-50', '50+'],
    "answer_index": 2,
  },
  {
    "id": 3,
    "question": "How are you feeling currently?",
    "options": ['Happy', 'Sad', 'Angry', 'Gloomy'],
    "answer_index": 2,
  },
  {
    "id": 4,
    "question": "Did you eat well today?",
    "options": ['Yes', 'No', 'Maybe', "Don't Know"],
    "answer_index": 2,
  },
];
