import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';
import 'theme.dart';

void main() => runApp(const KopiDanNyemilApp());

class KopiDanNyemilApp extends StatelessWidget {
  const KopiDanNyemilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kopi dan Nyemil',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: const SplashScreen(),
    );
  }
}