import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';
import 'dashboard.dart'; // Import DashboardPage yang baru

// Asumsi: LoginPage dan RegisterPage didefinisikan sebagai StatelessWidget atau StatefulWidget 
// di file 'login.dart' dan 'register.dart'.

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
        // Penggunaan 'const' di sini sudah tepat jika LoginPage adalah StatelessWidget dengan const constructor.
        '/login': (ctx) => const LoginPage(),
        '/register': (ctx) => const RegisterPage(),
        
        // Menggunakan DashboardPage yang baru dibuat
        '/dashboard': (ctx) => const DashboardPage(), 
      },
    );
  }
}