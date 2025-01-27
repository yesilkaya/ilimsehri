import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/color_styles.dart';
import '../models/question.dart';
import 'book_detail_screen.dart';

class CheckAnswersPage extends StatelessWidget {
  final List<Question> questions;
  final Map<int, dynamic> answers;
  final int questionNo;

  const CheckAnswersPage({Key? key, required this.questions, required this.answers, required this.questionNo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorStyles.appBackGroundColor,
        titleTextStyle: const TextStyle(color: ColorStyles.appTextColor),
        title: Text(
          'Cevaplar',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: 16, color: ColorStyles.appTextColor, fontWeight: FontWeight.bold),
          maxLines: 3,
        ),
        leading: const BackButton(
          color: ColorStyles.appTextColor,
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: questionNo + 1,
            itemBuilder: _buildItem,
          )
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final TextStyle textStyle =
        GoogleFonts.bubblegumSans(fontSize: 18, fontWeight: FontWeight.w600, color: ColorStyles.appTextColor);

    if (index == questionNo) {
      return Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 10),
        child: AppButton(
          text: 'Ana Sayfa',
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      );
    }
    Question question = questions[index];
    bool correct = question.correctAnswer == answers[index];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              question.question,
              style: textStyle.copyWith(color: Colors.black54),
            ),
            const SizedBox(height: 5.0),
            Text(answers[index], style: textStyle.copyWith(color: correct ? Colors.green : Colors.red)),
            const SizedBox(height: 5.0),
            correct
                ? Container()
                : Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: "Doğru Cevap: ",
                        style: textStyle.copyWith(color: correct ? Colors.green : Colors.black54),
                      ),
                      TextSpan(
                        text: question.correctAnswer,
                        style: textStyle.copyWith(color: Colors.green),
                      )
                    ]),
                    style: textStyle.copyWith(color: Colors.black54),
                  )
          ],
        ),
      ),
    );
  }
}
