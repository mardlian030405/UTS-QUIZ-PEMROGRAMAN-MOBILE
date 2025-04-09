import 'dart:async';
import 'package:flutter/material.dart';
import '../data/question_data.dart';

// Provider untuk mengatur logika kuis seperti jawaban, skor, dan timer
class QuizProvider with ChangeNotifier {
  List<Map<String, dynamic>> questionsList = questions; // Daftar pertanyaan dari file question_data.dart
  int questionIndex = 0;  // Indeks pertanyaan saat ini
  int correct = 0;        // Jumlah jawaban benar
  int wrong = 0;          // Jumlah jawaban salah
  int timer = 10;         // Waktu hitung mundur per soal
  Timer? _quizTimer;      // Objek Timer dari dart:async

  // Fungsi untuk memulai atau mengulang timer per soal
  void startTimer(VoidCallback onTimeUp) {
    _quizTimer?.cancel(); // Hentikan timer sebelumnya jika ada
    timer = 10; // Reset timer ke 10 detik
    _quizTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (timer > 0) {
        timer--; // Kurangi waktu
        notifyListeners(); // Update UI
      } else {
        t.cancel(); // Hentikan timer saat habis
        wrong++; // Hitung sebagai jawaban salah

        // Lanjut ke soal berikutnya atau tampilkan hasil jika soal habis
        if (questionIndex < questionsList.length - 1) {
          questionIndex++;
          startTimer(onTimeUp); // Timer soal berikutnya
        } else {
          onTimeUp(); // Selesaikan kuis
        }
        notifyListeners(); // Update UI
      }
    });
  }

  // Fungsi untuk mengecek jawaban yang dipilih user
  void checkAnswer(String? selectedOption, VoidCallback onQuizComplete) {
    _quizTimer?.cancel(); // Hentikan timer saat jawaban diberikan
    String correctAnswer = questionsList[questionIndex]['answer'];

    // Cek jawaban user dan tambahkan skor
    if (selectedOption == correctAnswer) {
      correct++;
    } else {
      wrong++;
    }

    // Lanjut ke soal berikutnya atau tampilkan hasil akhir
    if (questionIndex < questionsList.length - 1) {
      questionIndex++;
      startTimer(() => checkAnswer(null, onQuizComplete)); // Timer ulang
    } else {
      onQuizComplete(); // Kuis selesai
    }
    notifyListeners(); // Update UI
  }

  // Fungsi untuk mereset semua data dan mengulang kuis
  void restartQuiz() {
    _quizTimer?.cancel();
    questionIndex = 0;
    correct = 0;
    wrong = 0;
    timer = 10;
    notifyListeners();
  }

  // Fungsi untuk membatalkan timer jika perlu
  void cancelTimer() {
    _quizTimer?.cancel();
  }
}
