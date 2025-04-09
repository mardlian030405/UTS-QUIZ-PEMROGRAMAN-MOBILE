import 'package:flutter/material.dart';

// Halaman WelcomePage bersifat stateless (tidak membutuhkan state yang berubah)
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Mengatur latar belakang halaman menjadi putih
      backgroundColor: Colors.white,

      // Konten utama diletakkan di tengah layar
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Pusatkan secara vertikal
          children: [
            // Teks sambutan
            const Text(
              "Selamat Datang di MINDMI!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            // Gambar logo dari assets/images/logo.png
            Image.asset(
              'assets/images/logo.png',
              height: 400,
              width: 400,
              fit: BoxFit.contain, // Menyesuaikan gambar agar tidak terpotong
            ),

            const SizedBox(height: 20), // Jarak vertikal antar elemen

            // Deskripsi kuis
            const Center(
              child: Text(
                "Kuis Seputar D4 Manajemen Informatika",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center, // Teks rata tengah
              ),
            ),

            const SizedBox(height: 40), // Jarak sebelum tombol

            // Tombol untuk memulai kuis
            ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman kuis (route '/quiz')
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
