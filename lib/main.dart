import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/constants/colors.dart';

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
        scaffoldBackgroundColor: AppColors.darkGray,
      ),
      home: const Scaffold(
        body: Center(
          child: Text(
            'Hello World!',
            style: TextStyle(fontSize: 64),
          ),
        ),
      ),
    );
  }
}
