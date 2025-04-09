import 'package:flutter/material.dart';
import 'pages/welcome.dart'; // Import halaman Welcome
import 'pages/quiz.dart'; // Import halaman Quiz
import 'package:provider/provider.dart'; // Import package Provider
import 'providers/quiz_provider.dart'; // Import QuizProvider untuk state management

// Fungsi utama untuk menjalankan aplikasi
void main() {
  runApp(
    // Menyediakan QuizProvider ke seluruh aplikasi
    ChangeNotifierProvider(
      create: (_) => QuizProvider()..startTimer(() {}), // Inisialisasi dan mulai timer
      child: const MyApp(), // Menjalankan aplikasi utama
    ),
  );
}

// Widget utama aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan label "debug" di pojok
      title: 'Kuis D4MI', // Judul aplikasi
      theme: ThemeData(primarySwatch: Colors.indigo), // Tema aplikasi

      // Rute awal aplikasi (halaman pertama yang ditampilkan)
      initialRoute: '/',

      // Daftar rute aplikasi
      routes: {
        '/': (context) => const WelcomePage(), // Rute untuk halaman welcome
        '/quiz': (context) => const QuizPage(), // Rute untuk halaman kuis
      },
    );
  }
}
