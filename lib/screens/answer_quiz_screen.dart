import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/models/skill_development_model.dart';
import 'package:ywda/screens/submitted_quiz_result_screen.dart';

import '../widgets/answer_button.dart';

class AnswerQuizScreen extends StatefulWidget {
  final SkillDevelopmentModel selectedSkill;
  final SubSkillModel selectedSubskill;
  const AnswerQuizScreen(
      {super.key, required this.selectedSkill, required this.selectedSubskill});

  @override
  State<AnswerQuizScreen> createState() => _AnswerQuizScreenState();
}

class _AnswerQuizScreenState extends State<AnswerQuizScreen> {
  bool _isLoading = true;

  //  QUIZ VARIABLES
  List<dynamic> quizContent = [];
  Map<String, dynamic> currentChoices = {};
  int currentQuestionIndex = 0;
  List<dynamic> selectedAnswers = [];

  @override
  void initState() {
    super.initState();
    _loadQuiz();
  }

  Future _loadQuiz() async {
    String jsonData = await rootBundle.loadString('lib/data/quizzes.json');
    Map<dynamic, dynamic> allQuestions = json.decode(jsonData);
    if (allQuestions.containsKey(widget.selectedSubskill.subSkillName)) {
      quizContent = allQuestions[widget.selectedSubskill.subSkillName];
      currentChoices = quizContent[currentQuestionIndex]['options'];
      selectedAnswers = List.generate(quizContent.length, (index) => null);
      print(quizContent);

      setState(() {
        _isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('This subskill has no assigned quiz yet.')));
      Navigator.of(context).pop();
    }
  }

  void _answerQuestion(String selectedAnswer) {
    setState(() {
      if (selectedAnswers[currentQuestionIndex] != null &&
          selectedAnswers[currentQuestionIndex] == selectedAnswer) {
        selectedAnswers[currentQuestionIndex] = null;
      } else {
        selectedAnswers[currentQuestionIndex] = selectedAnswer;
      }
    });
  }

  bool _checkIfSelected(dynamic selectedAnswer) {
    bool selectedValue = false;

    setState(() {
      if (selectedAnswers[currentQuestionIndex] != null &&
          selectedAnswers[currentQuestionIndex] == selectedAnswer) {
        selectedValue = true;
      }
    });
    return selectedValue;
  }

  void _previousQuestion() {
    if (currentQuestionIndex == 0) {
      return;
    }
    currentQuestionIndex--;
    setState(() {
      currentChoices = quizContent[currentQuestionIndex]['options'];
    });
  }

  void _nextQuestion() {
    if (currentQuestionIndex == quizContent.length - 1) {
      //  Check if all items have been answered
      for (int i = 0; i < selectedAnswers.length; i++) {
        if (selectedAnswers[i] == null) {
          setState(() {
            currentQuestionIndex = i;
            currentChoices = quizContent[currentQuestionIndex]['options'];
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text('You have not yet answered question # ${i + 1}')));
          });
          return;
        }
      }
      _updateQuizAnswers();
      return;
    }
    currentQuestionIndex++;
    setState(() {
      currentChoices = quizContent[currentQuestionIndex]['options'];
    });
  }

  int countCorrectAnswers() {
    int numCorrect = 0;
    for (int i = 0; i < quizContent.length; i++) {
      if (quizContent[i]['answer'] == selectedAnswers[i]) {
        numCorrect++;
      }
    }
    return numCorrect;
  }

  void _updateQuizAnswers() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final currentUserData = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      Map<dynamic, dynamic> skillsDeveloped =
          currentUserData.data()!['skillsDeveloped'];
      int badgeLevel = 0;
      if (countCorrectAnswers() == 6 || countCorrectAnswers() == 7) {
        badgeLevel = 1;
      } else if (countCorrectAnswers() == 8 || countCorrectAnswers() == 9) {
        badgeLevel = 2;
      } else {
        badgeLevel = 3;
      }

      if (skillsDeveloped.containsKey(widget.selectedSkill.skillName)) {
        skillsDeveloped[widget.selectedSkill.skillName]
            [widget.selectedSubskill.subSkillName] = {
          'status': 'GRADED',
          'grade': badgeLevel,
          'score': countCorrectAnswers(),
          'answers': selectedAnswers,
          'remarks': ''
        };
      } else {
        skillsDeveloped[widget.selectedSkill.skillName] = {
          widget.selectedSubskill.subSkillName: {
            'status': 'GRADED',
            'grade': badgeLevel,
            'score': countCorrectAnswers(),
            'answers': selectedAnswers,
            'remarks': ''
          }
        };
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'skillsDeveloped': skillsDeveloped});

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully processed quiz results!')));
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SubmittedQuizResultScreen(
              selectedSkill: widget.selectedSkill,
              selectedSubskill: widget.selectedSubskill)));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error processing quiz results: $error')));
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text(widget.selectedSubskill.subSkillName,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(fontWeight: FontWeight.bold))),
      )),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  _questionContainer(
                      '${currentQuestionIndex + 1}. ${quizContent[currentQuestionIndex]['question']}'),
                  const SizedBox(height: 30),
                  ...currentChoices.entries.map((option) {
                    // Create a Container or any other widget for each choice
                    return AnswerButton(
                      letter: option.key,
                      answer: '${option.key}) ${option.value}',
                      onTap: () => _answerQuestion(option.key),
                      isSelected: _checkIfSelected(option.key),
                    );
                  }).toList(),
                  const SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _navigatorButton('PREVIOUS', _previousQuestion),
                      _navigatorButton('NEXT', _nextQuestion)
                    ],
                  )
                ],
              )),
    );
  }

  Widget _questionContainer(String question) {
    return Container(
      height: 150,
      width: MediaQuery.sizeOf(context).width * 0.95,
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 21, 57, 119),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 23),
        child: SingleChildScrollView(
          child: Text(question,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _navigatorButton(String text, void Function() onPress) {
    return SizedBox(
        width: 100,
        child: ElevatedButton(
          onPressed: onPress,
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 34, 52, 189)),
          child: Text(text),
        ));
  }
}
