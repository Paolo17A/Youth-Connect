import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ywda/screens/add_emotion_entry_screen.dart';
import 'package:ywda/screens/all_faqs_screen.dart';
import 'package:ywda/screens/all_projects_screen.dart';
import 'package:ywda/screens/all_organizations_screen.dart';
import 'package:ywda/screens/edit_gender_screen.dart';
import 'package:ywda/screens/edit_profile_screen.dart';
import 'package:ywda/screens/emotional_tracker_screen.dart';
import 'package:ywda/screens/forgot_password_screen.dart';
import 'package:ywda/screens/gender_development_screen.dart';
import 'package:ywda/screens/home_screen.dart';
import 'package:ywda/screens/login_screen.dart';
import 'package:ywda/screens/lusog_isip_screen.dart';
import 'package:ywda/screens/mental_health_screen.dart';
import 'package:ywda/screens/new_self_identification_screen.dart';
import 'package:ywda/screens/overall_leaderboard_screen.dart';
import 'package:ywda/screens/personal_shield_screen.dart';
import 'package:ywda/screens/self_assessment_screen.dart';
import 'package:ywda/screens/self_identification_category_screen.dart';
import 'package:ywda/screens/self_identification_screen.dart';
import 'package:ywda/screens/sign_up_screen.dart';
import 'package:ywda/screens/skills_development_screen.dart';
import 'package:ywda/screens/answer_survey_screen.dart';
import 'package:ywda/screens/slave_of_socials_screen.dart';
import 'package:ywda/screens/tolerance_test_screen.dart';
import 'package:ywda/screens/twenty_statements_screen.dart';
import 'package:ywda/screens/user_profile.dart';
import 'package:ywda/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Map<String, WidgetBuilder> _routes = {
    '/': (context) => const WelcomeScreen(),
    '/login': (context) => const LoginScreen(),
    '/signup': (context) => const SignUpScreen(),
    '/forgot': (context) => const ForgotPasswordScreen(),
    '/home': (context) => const HomeScreen(),
    '/assessment': (context) => const SelfAssessmentScreen(),
    '/organization': (context) => const AllOrganizationsScreen(),
    '/mentalHealth': (context) => const MentalHealthScreen(),
    '/lusogIsip': (context) => const LusogIsip(),
    '/events': (context) => const AllProjectsScreen(),
    '/profile': (context) => const UserProfileScreen(),
    '/edit': (context) => EditProfileScreen(),
    '/skills': (context) => const SkillsDevelopmentScreen(),
    '/answerSurvey': (context) => const AnswerSurveyScreen(),
    '/selfIdentification': (context) => const SelfIdentificationScreen(),
    '/newSelfIdentification': (context) => const NewSelfIdentificationScreen(),
    '/selfIdentificationCategory': (context) =>
        const SelfIdentificationCategoryScreen(),
    '/genderDevelopment': (context) => const GenderDevelopmentScreen(),
    '/editGender': (context) => const EditGenderScreen(),
    '/overallLeaderboard': (context) => const OverallLeaderboardScreen(),
    '/faqs': (context) => const AllFAQsScreen(),
    '/toleranceTest': (context) => const ToleranceTestScreen(),
    '/slaveOfSocials': (context) => const SlaveOfSocialsScreen(),
    '/personalShield': (context) => const PersonalShieldScreen(),
    '/twentyStatements': (context) => const TwentyStatementsScreen(),
    '/addEmotion': (context) => const AddEmotionEntry(),
    '/emotionTracker': (context) => const EmotionalTrackerScreen()
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
