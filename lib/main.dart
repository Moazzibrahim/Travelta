import 'package:flutter/material.dart';
import 'package:flutter_travelta/controllers/Auth/login_provider.dart';
import 'package:flutter_travelta/view/screens/splash/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LoginProvider(),
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
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
      ),
      title: 'Travelta',
      home: const SplashScreen(),
    );
  }
}
