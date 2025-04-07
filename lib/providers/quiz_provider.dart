import 'dart:async';
import 'package:flutter/material.dart';
import '../data/question_data.dart';

class QuizProvider with ChangeNotifier {
  List<Map<String, dynamic>> questionsList = questions;
  int questionIndex = 0;
  int correct = 0;
  int wrong = 0;
  int timer = 10;
  Timer? _quizTimer;

  void startTimer(VoidCallback onTimeUp) {
    _quizTimer?.cancel();
    timer = 10;
    _quizTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (timer > 0) {
        timer--;
        notifyListeners();
      } else {
        t.cancel();
        onTimeUp();
      }
    });
  }

  void checkAnswer(String? selectedOption, VoidCallback onQuizComplete) {
    _quizTimer?.cancel();
    String correctAnswer = questionsList[questionIndex]['answer'];
    if (selectedOption == correctAnswer) {
      correct++;
    } else {
      wrong++;
    }

    if (questionIndex < questionsList.length - 1) {
      questionIndex++;
      startTimer(() => checkAnswer(null, onQuizComplete));
    } else {
      onQuizComplete();
    }
    notifyListeners();
  }

  void restartQuiz() {
    _quizTimer?.cancel();
    questionIndex = 0;
    correct = 0;
    wrong = 0;
    timer = 10;
    notifyListeners();
  }

  void cancelTimer() {
    _quizTimer?.cancel();
  }
}
