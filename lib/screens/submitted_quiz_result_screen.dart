import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/models/skill_development_model.dart';

class SubmittedQuizResultScreen extends StatefulWidget {
  final SkillDevelopmentModel selectedSkill;
  final SubSkillModel selectedSubskill;
  const SubmittedQuizResultScreen(
      {super.key, required this.selectedSkill, required this.selectedSubskill});

  @override
  State<SubmittedQuizResultScreen> createState() =>
      _SubmittedQuizResultScreenState();
}

class _SubmittedQuizResultScreenState extends State<SubmittedQuizResultScreen> {
  bool _isLoading = true;
  List<dynamic> quizContent = [];
  List<dynamic> answers = [];
  int score = 0;
  @override
  void initState() {
    super.initState();
    initializeQuizResults();
  }

  void initializeQuizResults() async {
    try {
      //  Get the necessary quiz content form the json file.
      String jsonData = await rootBundle.loadString('lib/data/quizzes.json');
      Map<dynamic, dynamic> allQuestions = json.decode(jsonData);
      quizContent = allQuestions[widget.selectedSubskill.subSkillName];

      //  Get the quiz results and score from Firebase
      final currentUserData = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      Map<dynamic, dynamic> skillsDeveloped =
          currentUserData.data()!['skillsDeveloped'];
      answers = skillsDeveloped[widget.selectedSkill.skillName]
          [widget.selectedSubskill.subSkillName]['answers'];
      score = skillsDeveloped[widget.selectedSkill.skillName]
          [widget.selectedSubskill.subSkillName]['score'];
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error getting quiz results: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, ModalRoute.withName('/skills'));
        Navigator.pushReplacementNamed(context, '/skills');
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
              title: Center(
                  child: Text(widget.selectedSubskill.subSkillName,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(fontWeight: FontWeight.bold))))),
          body: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 21, 57, 119)),
                      height: 60,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'You got ${score.toString()} out of ${quizContent.length} questions correct',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: quizContent.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    height: 130,
                                    decoration: const BoxDecoration(
                                        color: Color.fromARGB(255, 27, 67, 136),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Column(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                              child: Text('${index + 1}. ',
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13))),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.75,
                                              child: Text(
                                                  '${quizContent[index]['question']}',
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13))),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              _answerText(
                                                  'Your Answer: ${answers[index] as String}) ${quizContent[index]['options'][answers[index] as String]}'),
                                              _answerText(
                                                  'Correct Answer: ${quizContent[index]['answer'] as String}) ${quizContent[index]['options'][quizContent[index]['answer'] as String]}')
                                            ],
                                          )
                                        ],
                                      )
                                    ]),
                                  ));
                            }),
                      ),
                    )
                  ]))),
    );
  }

  Widget _answerText(String answer) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(
        answer,
        style: GoogleFonts.poppins(
            textStyle: TextStyle(color: Colors.white, fontSize: 10)),
      ),
    );
  }
}
