import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/models/skill_development_model.dart';
import 'package:ywda/screens/answer_quiz_screen.dart';
import 'package:ywda/screens/selected_subskill_screen.dart';
import 'package:ywda/screens/submitted_quiz_result_screen.dart';
import 'package:ywda/screens/submitted_subskill_result_screen.dart';

class SelectedSkillScreen extends StatefulWidget {
  final SkillDevelopmentModel selectedSkill;
  const SelectedSkillScreen({super.key, required this.selectedSkill});

  @override
  State<SelectedSkillScreen> createState() => _SelectedSkillScreenState();
}

class _SelectedSkillScreenState extends State<SelectedSkillScreen> {
  bool _isLoading = true;
  Map developedSkills = {};
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    try {
      final currentUserData = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      developedSkills = currentUserData.data()!['skillsDeveloped'];

      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error getting developed skills: $error')));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              widget.selectedSkill.assetPath.isNotEmpty
                  ? Transform.scale(
                      scale: 0.8,
                      child: Image.asset(widget.selectedSkill.assetPath))
                  : Icon(Icons.star, color: Colors.black),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .55,
                  child: Text(widget.selectedSkill.skillName,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold))),
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon:
                      Image.asset('lib/assets/images/icons/icons-ranking.png'))
            ],
          )),
          automaticallyImplyLeading: false),
      body: SafeArea(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children:
                            widget.selectedSkill.subSkills.map((subskill) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 5,
                                        spreadRadius: 2,
                                        offset: Offset(0, 5))
                                  ],
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.55,
                                          child: Text(subskill.subSkillName,
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20))),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  if (developedSkills
                                                          .containsKey(widget
                                                              .selectedSkill
                                                              .skillName) &&
                                                      (developedSkills[widget
                                                                  .selectedSkill
                                                                  .skillName]
                                                              as Map<dynamic,
                                                                  dynamic>)
                                                          .containsKey(subskill
                                                              .subSkillName)) {
                                                    if (subskill
                                                            .requiredTaskType ==
                                                        TaskType.QUIZ) {
                                                      return SubmittedQuizResultScreen(
                                                          selectedSkill: widget
                                                              .selectedSkill,
                                                          selectedSubskill:
                                                              subskill);
                                                    } else {
                                                      return SubmittesSubskillResultScreen(
                                                          thisSubskill:
                                                              subskill,
                                                          submittedSubskill:
                                                              developedSkills[widget
                                                                      .selectedSkill
                                                                      .skillName]
                                                                  [subskill
                                                                      .subSkillName]);
                                                    }
                                                  } else {
                                                    return subskill
                                                                .requiredTaskType ==
                                                            TaskType.QUIZ
                                                        ? AnswerQuizScreen(
                                                            selectedSkill: widget
                                                                .selectedSkill,
                                                            selectedSubskill:
                                                                subskill)
                                                        : SelectedSubskillScreen(
                                                            selectedSkill: widget
                                                                .selectedSkill,
                                                            selectedSubskill:
                                                                subskill);
                                                  }
                                                }));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30))),
                                              child: Text('Start',
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.bold))),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ))),
    );
  }
}
