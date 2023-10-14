import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/models/skill_development_model.dart';
import 'package:ywda/screens/answer_quiz_screen.dart';
import 'package:ywda/screens/selected_subskill_screen.dart';
import 'package:ywda/screens/skill_leaderboard_screen.dart';
import 'package:ywda/screens/submitted_quiz_result_screen.dart';
import 'package:ywda/screens/submitted_subskill_result_screen.dart';
import 'package:ywda/widgets/custom_styling_widgets.dart';

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
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SkillLeaderboardScreen(
                            selectedSkill: widget.selectedSkill)));
                  },
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
                              decoration: decorationWithShadow(),
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
                                        _subskillActionButton(subskill)
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

  Widget _subskillActionButton(SubSkillModel subskill) {
    bool hasSubskillEntry =
        developedSkills.containsKey(widget.selectedSkill.skillName) &&
            (developedSkills[widget.selectedSkill.skillName]
                    as Map<dynamic, dynamic>)
                .containsKey(subskill.subSkillName);

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.2,
      child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              //  Already did the task for this subskill
              if (hasSubskillEntry) {
                //  Task is a Quiz
                if (subskill.requiredTaskType == TaskType.QUIZ) {
                  return SubmittedQuizResultScreen(
                      selectedSkill: widget.selectedSkill,
                      selectedSubskill: subskill);
                }
                //  Task is either a video or an essay
                else {
                  return SubmittesSubskillResultScreen(
                      thisSkill: widget.selectedSkill,
                      thisSubskill: subskill,
                      submittedSubskill:
                          developedSkills[widget.selectedSkill.skillName]
                              [subskill.subSkillName],
                      remarks: developedSkills[widget.selectedSkill.skillName]
                          [subskill.subSkillName]['remarks']);
                }
              } else {
                return subskill.requiredTaskType == TaskType.QUIZ
                    ? AnswerQuizScreen(
                        selectedSkill: widget.selectedSkill,
                        selectedSubskill: subskill)
                    : SelectedSubskillScreen(
                        selectedSkill: widget.selectedSkill,
                        selectedSubskill: subskill);
              }
            }));
          },
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
          child: Text(hasSubskillEntry ? 'Results' : 'Start',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: hasSubskillEntry ? 11 : 16))),
    );
  }
}
