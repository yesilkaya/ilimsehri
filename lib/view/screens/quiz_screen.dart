import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/color_styles.dart';
import '../../helper/text_helper.dart';
import '../models/category.dart';
import '../models/question.dart';
import 'book_detail_screen.dart';
import 'quiz_finished.dart';

class QuizScreen extends StatefulWidget {
  final List<Question> questions;
  final Category category;
  final int numberOfQuestion;

  const QuizScreen({super.key, required this.questions, required this.category, required this.numberOfQuestion});

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  final TextStyle _questionStyle = GoogleFonts.comicNeue(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: ColorStyles.appTextColor,
  );

  int _currentIndex = 0;
  final Map<int, dynamic> _answers = {};
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Question question = widget.questions[_currentIndex];
    final List<dynamic> options = question.incorrectAnswers;
    if (!options.contains(question.correctAnswer)) {
      options.add(question.correctAnswer);
      options.shuffle();
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => _onWillPop(didPop, result),
      child: Scaffold(
        backgroundColor: ColorStyles.appBackGroundColor,
        key: _key,
        appBar: AppBar(
          backgroundColor: ColorStyles.appBackGroundColor,
          titleTextStyle: const TextStyle(color: ColorStyles.appTextColor),
          title: Text(
            TextHelper.capitalizeWords(widget.category.name),
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
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: ColorStyles.appTextColor,
                    child: Text("${_currentIndex + 1}",
                        style: _questionStyle.copyWith(color: ColorStyles.appBackGroundColor)),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 40),
                  Flexible(
                    child: Text(
                      widget.questions[_currentIndex].question,
                      style: _questionStyle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Card(
                shadowColor: Theme.of(context).hintColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: ColorStyles.sepya,
                elevation: 8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ...options.map((option) => RadioListTile<String>(
                          value: option,
                          groupValue: _answers[_currentIndex],
                          onChanged: (value) {
                            setState(() {
                              _answers[_currentIndex] = option;
                            });
                          },
                          title: Text(
                            option,
                            style: _questionStyle.copyWith(color: ColorStyles.appBackGroundColor),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Container(
                  alignment: Alignment.bottomCenter,
                  child: AppButton(
                      text: _currentIndex == (widget.numberOfQuestion - 1) ? "Gönder" : "Diğer Soru",
                      onPressed: _nextSubmit)),
            ],
          ),
        ),
      ),
    );
  }

  void _nextSubmit() {
    if (_answers[_currentIndex] == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: ColorStyles.appTextColor,
        content: Text(
          "Bir şık işaretlemeden geçemezsin",
          style: _questionStyle.copyWith(color: ColorStyles.appBackGroundColor),
        ),
      ));
      return;
    }
    if (_currentIndex < (widget.numberOfQuestion - 1)) {
      setState(() {
        _currentIndex++;
      });
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => QuizFinishedPage(
                questions: widget.questions,
                answers: _answers,
                numberOfQuestion: widget.numberOfQuestion,
              )));
    }
  }

  Future<void> _onWillPop(
    bool didPop,
    Object? result,
  ) async {
    if (didPop) {
      return; // Eğer başarılı şekilde geri gidildiyse, işlemi durdur
    }

    bool? shouldPop = await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: ColorStyles.appTextColor,
          content: Text(
            "Diğer soruları cevaplamadan gitmekte kararlı mısın?",
            style: _questionStyle.copyWith(color: ColorStyles.appBackGroundColor),
          ),
          title: Text(
            "Dur!",
            style: _questionStyle.copyWith(color: ColorStyles.appBackGroundColor),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: ColorStyles.appBackGroundColor),
                child: Text(
                  "Kararım Net",
                  style: _questionStyle,
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: ColorStyles.appBackGroundColor),
              child: Text(
                "Bir Daha Düşüneyim",
                style: _questionStyle,
              ),
              onPressed: () {
                Navigator.pop(context, false); // Dialogu kapat ve false döndür
              },
            ),
          ],
        );
      },
    );
    if (shouldPop == true) {
      Navigator.of(context).pop(true); // Sayfayı kapat
    }
  }
}
