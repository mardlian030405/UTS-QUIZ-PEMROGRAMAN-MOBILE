import 'package:flutter/material.dart';
import 'pages/welcome.dart';
import 'pages/quiz.dart';
import 'package:provider/provider.dart';
import 'providers/quiz_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => QuizProvider()..startTimer(() {}),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kuis D4MI',
      theme: ThemeData(primarySwatch: Colors.indigo),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/quiz': (context) => const QuizPage(),
      },
    );
  }
}
