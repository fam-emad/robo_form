import 'package:flutter/material.dart'; 
import 'core/app_colors.dart';
import 'screens/registration_screen.dart';

void main() => runApp(const RoboTechApp());

class RoboTechApp extends StatelessWidget {
  const RoboTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RoboTech',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.bg,
        // textTheme: GoogleFonts.spaceGroteskTextTheme(
        //   ThemeData.dark().textTheme,
        // ),
      ),
      home: const RegistrationScreen(),
    );
  }
}
