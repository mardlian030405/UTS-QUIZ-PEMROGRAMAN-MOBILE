import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/result_widget.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  void initState() {
    super.initState();
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    quizProvider.startTimer(() {
      if (mounted) {
        showResult(quizProvider);
      }
    });
  }

  void showResult(QuizProvider provider) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ResultWidget(
          score: provider.correct * 10,
          correct: provider.correct,
          wrong: provider.wrong,
          total: provider.questionsList.length,
          onRestart: () {
            provider.restartQuiz();
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
        final question = provider.questionsList[provider.questionIndex];

        return Scaffold(
          appBar: AppBar(title: const Text("Kuis D4MI")),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Top row: timer, score, question count
                Row(
                  children: [
                    Expanded(
                      child: Text("⏳ ${provider.timer}s",
                          style: const TextStyle(color: Colors.red)),
                    ),
                    Expanded(
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.check, color: Colors.green),
                            Text(" ${provider.correct}  "),
                            const Icon(Icons.close, color: Colors.red),
                            Text(" ${provider.wrong}"),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                            "Soal: ${provider.questionIndex + 1}/${provider.questionsList.length}"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Question centered vertically
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          question['question'],
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Answer buttons positioned slightly below
                      ...question['options'].map<Widget>((option) {
                        return Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              padding:
                              const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () {
                              provider.checkAnswer(option, () {
                                if (mounted) {
                                  showResult(provider);
                                }
                              });
                            },
                            child: Text(option,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white)),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
