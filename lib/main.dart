// file: main.dart

import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oratorio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF004D40)),
        useMaterial3: true,
      ),
      initialRoute: '/login', 
      routes: {
        // LoginPage dan RegisterPage adalah const
        '/': (ctx) => const LoginPage(),
        '/login': (ctx) => const LoginPage(),
        '/register': (ctx) => const RegisterPage(),
        
        // Hapus keyword 'const' di sini!
        '/dashboard': (ctx) => Scaffold( 
              appBar: AppBar(
                title: const Text('Dashboard Utama'), // Tambahkan const ke Text
                backgroundColor: const Color(0xFF004D40), // Tambahkan const ke Color
                foregroundColor: Colors.white,
                automaticallyImplyLeading: false, 
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0), // Tambahkan const jika memungkinkan
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text( // Tambahkan const
                        'Selamat Datang di Dashboard Oratorio!',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      const Text('Anda telah berhasil login.', textAlign: TextAlign.center), // Tambahkan const
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          // Operasi Navigasi (Non-konstan)
                          Navigator.pushNamedAndRemoveUntil(
                            ctx, 
                            '/login', 
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF004D40),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        ),
                        child: const Text('LOGOUT'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      },
    );
  }
}