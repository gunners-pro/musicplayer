import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/constants/colors.dart';
import 'package:musicplayer/screens/library.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.ubuntuTextTheme().apply(
          bodyColor: AppColors.lightGray,
        ),
        scaffoldBackgroundColor: AppColors.bg,
      ),
      home: const Libray(),
    );
  }
}
