import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ywda/screens/all_events_screen.dart';
import 'package:ywda/screens/all_organizations_screen.dart';
import 'package:ywda/screens/home_screen.dart';
import 'package:ywda/screens/login_screen.dart';
import 'package:ywda/screens/register_screen.dart';
import 'package:ywda/screens/self_assessment_screen.dart';
import 'package:ywda/screens/sign_up_screen.dart';
import 'package:ywda/screens/skills_development_screen.dart';
import 'package:ywda/screens/answer_survey_screen.dart';
import 'package:ywda/screens/user_profile.dart';
import 'package:ywda/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Map<String, WidgetBuilder> _routes = {
    '/': (context) => const WelcomeScreen(),
    '/login': (context) => const LoginScreen(),
    '/signup': (context) => const SignUpScreen(),
    '/register': (context) => const RegisterScreen(),
    '/home': (context) => const HomeScreen(),
    '/assessment': (context) => const SelfAssessmentScreen(),
    '/organization': (context) => const AllOrganizationsScreen(),
    '/events': (context) => const AllEventsScreen(),
    '/profile': (context) => const UserProfileScreen(),
    '/skills': (context) => const SkillsDevelopmentScreen(),
    '/answerSurvey': (context) => const AnswerSurveyScreen()
  };

  final ThemeData _themeData = ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 21, 57, 119)),
      scaffoldBackgroundColor: const Color.fromARGB(255, 227, 236, 244),
      snackBarTheme: const SnackBarThemeData(
          backgroundColor: Color.fromARGB(255, 53, 113, 217)),
      appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Color.fromARGB(255, 227, 236, 244)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 217, 217, 217),
          unselectedItemColor: Colors.black,
          selectedItemColor: Color.fromARGB(255, 53, 113, 217)),
      listTileTheme: const ListTileThemeData(
          iconColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadiusDirectional.all(Radius.circular(10)))),
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 53, 113, 217)))));

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Youth Connect',
      theme: _themeData,
      routes: _routes,
      initialRoute: '/',
    );
  }
}
