import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const OracleApp());
}

class OracleApp extends StatelessWidget {
  const OracleApp({super.key});

  static const Color bgColor = Color(0xFF0A0A0F);
  static const Color goldColor = Color(0xFFD4A017);
  static const Color textColor = Color(0xFFF5F0E8);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oracle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: bgColor,
        brightness: Brightness.dark,
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      home: const OracleSplash(),
    );
  }
}

class OracleSplash extends StatelessWidget {
  const OracleSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ORACLE',
              style: GoogleFonts.playfairDisplay(
                fontSize: 56,
                fontWeight: FontWeight.w700,
                color: OracleApp.goldColor,
                letterSpacing: 8,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'aaj kya hoga?',
              style: GoogleFonts.playfairDisplay(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: OracleApp.textColor.withOpacity(0.7),
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
