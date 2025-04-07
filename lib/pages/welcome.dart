import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 400,
              width: 400,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const Text(
              "Selamat Datang di MINDMI!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Center(
              child: Text(
                "Kuis Seputar D4 Manajemen Informatika",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center, // agar teksnya juga center jika multiline
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/quiz');
              },
              child: const Text("Mulai Kuis"),
            )
          ],
        ),
      ),
    );
  }
}
