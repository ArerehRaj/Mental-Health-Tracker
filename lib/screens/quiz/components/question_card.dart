import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/controllers/question_controller.dart';
import '/models/Questions.dart';

import '../../../constants.dart';
import 'option.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    // it means we have to pass this
    required this.question,
  }) : super(key: key);

  final FirebaseQuestion question;

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Material(
      elevation: 100,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        padding: EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          // border: Border.all(color: Colors.black, width: 1),
        ),
        child: Column(
          children: [
            Text(
              question.question,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: kBlackColor),
            ),
            SizedBox(height: kDefaultPadding / 2),
            if (question.isMcq)
              ...List.generate(
                question.options.length,
                (index) => Option(
                  index: index,
                  text: question.options[index]['ans'],
                  press: () =>
                      _controller.checkAns(question, index, question.isMcq),
                  key: null,
                ),
              ),
            if (!question.isMcq)
              ...List.generate(
                2,
                (index) => Option(
                  index: index,
                  text: index == 0 ? 'Yes' : 'No',
                  press: () =>
                      _controller.checkAns(question, index, question.isMcq),
                  key: null,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
