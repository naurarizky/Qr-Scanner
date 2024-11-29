import 'package:flutter/material.dart';
import 'package:qr_scanner/splash_screen.dart';

void main() {
  runApp(const QrScanner());
}

class QrScanner extends StatelessWidget {
  const QrScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 255, 255, 255), // Warna oranye 
      ),
      home: const SplashScreen(),
    );
  }
}
