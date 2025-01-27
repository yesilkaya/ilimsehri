import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/color_styles.dart';
import '../models/question.dart';
import 'check_answers.dart';

class QuizFinishedPage extends StatefulWidget {
  final List<Question> questions;
  final Map<int, dynamic> answers;
  final int numberOfQuestion;

  const QuizFinishedPage({Key? key, required this.questions, required this.answers, required this.numberOfQuestion})
      : super(key: key);

  @override
  State<QuizFinishedPage> createState() => _QuizFinishedPageState();
}

class _QuizFinishedPageState extends State<QuizFinishedPage> {
  late int correctAnswers;
  final TextStyle textStyle =
      GoogleFonts.bubblegumSans(fontSize: 18, fontWeight: FontWeight.w600, color: ColorStyles.appTextColor);

  @override
  Widget build(BuildContext context) {
    int correct = 0;
    widget.answers.forEach((index, value) {
      if (widget.questions[index].correctAnswer == value) correct++;
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorStyles.appBackGroundColor,
        titleTextStyle: const TextStyle(color: ColorStyles.appTextColor),
        title: Text(
          'Sonuç',
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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [ColorStyles.appTextColor, ColorStyles.appBackGroundColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Toplam Soru", style: textStyle.copyWith(color: ColorStyles.appBackGroundColor)),
                  trailing: Text("${widget.numberOfQuestion}",
                      style: textStyle.copyWith(color: ColorStyles.appBackGroundColor)),
                ),
              ),
              const SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Puan", style: textStyle.copyWith(color: ColorStyles.appBackGroundColor)),
                  trailing: Text("${correct / widget.numberOfQuestion * 100}%",
                      style: textStyle.copyWith(color: ColorStyles.appBackGroundColor)),
                ),
              ),
              const SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Doğru Cevap", style: textStyle.copyWith(color: ColorStyles.appBackGroundColor)),
                  trailing: Text("$correct/${widget.numberOfQuestion}",
                      style: textStyle.copyWith(color: ColorStyles.appBackGroundColor)),
                ),
              ),
              const SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text("Yanlış Cevap", style: textStyle.copyWith(color: ColorStyles.appBackGroundColor)),
                  trailing: Text("${widget.numberOfQuestion - correct}/${widget.numberOfQuestion}",
                      style: textStyle.copyWith(color: ColorStyles.appBackGroundColor)),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Ana Sayfa', style: textStyle),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => CheckAnswersPage(
                                questions: widget.questions,
                                answers: widget.answers,
                                questionNo: widget.numberOfQuestion,
                              )));
                    },
                    child: Text('Cevaplara Bak', style: textStyle),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
