import 'package:flutter/material.dart';
import 'package:yamm_app/pages/load_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 0, 0, 0),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          // ···
          titleLarge: GoogleFonts.dosis(
            fontSize: 30,
            fontStyle: FontStyle.italic,
          ),
          titleMedium: GoogleFonts.dosis(
            fontSize: 20,
          ),
          titleSmall: GoogleFonts.dosis(
            fontSize: 15,
          ),

          bodyMedium: GoogleFonts.dosis(fontSize: 18),
          displaySmall: GoogleFonts.dosis(),
          labelLarge: GoogleFonts.dosis(fontSize: 17),
          labelMedium: GoogleFonts.dosis(fontSize: 15),
          labelSmall: GoogleFonts.dosis(fontSize: 20),
          bodySmall: GoogleFonts.dosis(fontSize: 15),
        ),
      ),
      home: const LoadPage(title: 'Flutter Demo Home Page'),
    );
  }
}
