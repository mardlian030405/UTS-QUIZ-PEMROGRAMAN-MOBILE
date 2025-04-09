import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/result_widget.dart';

// Halaman utama yang menampilkan tampilan dan logika kuis
class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  void initState() {
    super.initState();

    // Mengakses provider untuk menginisialisasi timer
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);

    // Mulai timer ketika halaman dimuat
    quizProvider.startTimer(() {
      if (mounted) {
        showResult(quizProvider); // Tampilkan hasil jika waktu habis
      }
    });
  }

  // Fungsi untuk menampilkan halaman hasil kuis
  void showResult(QuizProvider provider) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ResultWidget(
          score: provider.correct * 10, // Skor = jumlah benar x 10
          correct: provider.correct,
          wrong: provider.wrong,
          total: provider.questionsList.length,
          onRestart: () {
            provider.restartQuiz(); // Reset data kuis saat mulai ulang
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const QuizPage()),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, provider, child) {
        final question = provider.questionsList[provider.questionIndex]; // Ambil pertanyaan saat ini

        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 1,
            title: const Text("KUIS MINDMI"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Baris indikator: timer, benar, salah, soal ke-
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfoCard(
                      icon: Icons.timer,
                      label: "${provider.timer}s",
                      color: Colors.redAccent,
                    ),
                    _buildInfoCard(
                      icon: Icons.check_circle,
                      label: "${provider.correct}",
                      color: Colors.green,
                    ),
                    _buildInfoCard(
                      icon: Icons.cancel,
                      label: "${provider.wrong}",
                      color: Colors.red,
                    ),
                    _buildInfoCard(
                      icon: Icons.help_outline,
                      label: "${provider.questionIndex + 1}/${provider.questionsList.length}",
                      color: Colors.blueAccent,
                    ),
                  ],
                ),

                const Spacer(flex: 1), // Spacer agar pertanyaan naik sedikit ke atas

                // Container untuk menampilkan pertanyaan di tengah atas
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    question['question'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const Spacer(flex: 2), // Spacer agar pilihan jawaban tetap di bawah

                // Daftar pilihan jawaban
                Column(
                  children: question['options'].map<Widget>((option) {
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        onPressed: () {
                          provider.checkAnswer(option, () {
                            if (mounted) showResult(provider); // Cek jawaban & tampilkan hasil jika kuis selesai
                          });
                        },
                        child: Text(
                          option,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }).toList(), // Konversi daftar jawaban ke widget
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget indikator informasi (timer, benar, salah, soal ke-)
  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
