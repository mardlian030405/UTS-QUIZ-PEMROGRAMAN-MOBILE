import 'package:flutter/material.dart';
import '../providers/quiz_provider.dart';
import 'package:provider/provider.dart';
import '../pages/welcome.dart';

class ResultWidget extends StatelessWidget {
  final int score;
  final int correct;
  final int wrong;
  final int total;
  final VoidCallback onRestart;

  const ResultWidget({
    super.key,
    required this.score,
    required this.correct,
    required this.wrong,
    required this.total,
    required this.onRestart,
  });

  String getResultText() {
    if (score == 100) return "Profesor!";
    if (score >= 90) return "Sangat Jenius!";
    if (score >= 60) return "Cukup Baik!";
    return "Tetap Semangat!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hasil Kuis",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text("Skor: $score / ${total * 10}", style: const TextStyle(fontSize: 22)),
              Text("Benar: $correct", style: const TextStyle(fontSize: 18, color: Colors.green)),
              Text("Salah: $wrong", style: const TextStyle(fontSize: 18, color: Colors.red)),
              const SizedBox(height: 20),
              Text(getResultText(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  Provider.of<QuizProvider>(context, listen: false).restartQuiz();
                  Navigator.pushReplacementNamed(context, '/quiz');
                },
                child: const Text("Ulangi Kuis"),
              ),

              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const WelcomePage()),
                  );
                },
                child: const Text("Kembali ke Beranda"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
