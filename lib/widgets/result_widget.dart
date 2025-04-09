import 'package:flutter/material.dart';
import '../providers/quiz_provider.dart';
import 'package:provider/provider.dart';
import '../pages/welcome.dart';

// Widget untuk menampilkan hasil akhir kuis
class ResultWidget extends StatelessWidget {
  final int score;       // Nilai akhir kuis
  final int correct;     // Jumlah jawaban benar
  final int wrong;       // Jumlah jawaban salah
  final int total;       // Total jumlah soal
  final VoidCallback onRestart; // Callback ketika tombol restart ditekan

  const ResultWidget({
    super.key,
    required this.score,
    required this.correct,
    required this.wrong,
    required this.total,
    required this.onRestart,
  });

  // Fungsi untuk menampilkan teks hasil berdasarkan skor
  String getResultText() {
    if (score == 100) return "Profesor!";
    if (score >= 90) return "Sangat Jenius!";
    if (score >= 60) return "Cukup Baik!";
    return "Belejar lagi yaaa!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50], // Latar belakang hijau muda
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Judul halaman hasil
              Text(
                "Hasil Kuis",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Menampilkan nilai dan statistik jawaban
              Text("Skor: $score / ${total * 10}", style: const TextStyle(fontSize: 22)),
              Text("Benar: $correct", style: const TextStyle(fontSize: 18, color: Colors.green)),
              Text("Salah: $wrong", style: const TextStyle(fontSize: 18, color: Colors.red)),

              const SizedBox(height: 20),

              // Menampilkan pesan hasil berdasarkan skor
              Text(getResultText(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

              const SizedBox(height: 40),

              // Tombol untuk mengulangi kuis
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  Provider.of<QuizProvider>(context, listen: false).restartQuiz(); // Reset quiz
                  Navigator.pushReplacementNamed(context, '/quiz'); // Kembali ke halaman kuis
                },
                child: const Text("Ulangi Kuis"),
              ),

              const SizedBox(height: 10),

              // Tombol untuk kembali ke halaman beranda
              TextButton(
                onPressed: () {
                  // Reset kuis sebelum kembali ke beranda
                  Provider.of<QuizProvider>(context, listen: false).restartQuiz();

                  // Navigasi ke halaman beranda (WelcomePage)
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const WelcomePage()),
                  );
                },
                child: const Text("Kembali ke Beranda"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
