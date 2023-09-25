import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/models/skill_development_model.dart';
import 'package:ywda/screens/selected_skill_screen.dart';
import 'package:ywda/widgets/app_bottom_navbar_widget.dart';

class SkillsDevelopmentScreen extends StatefulWidget {
  const SkillsDevelopmentScreen({super.key});

  @override
  State<SkillsDevelopmentScreen> createState() =>
      _SkillsDevelopmentScreenState();
}

class _SkillsDevelopmentScreenState extends State<SkillsDevelopmentScreen> {
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
              child: Text('Skill Development Journey',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontWeight: FontWeight.bold))),
            ),
            automaticallyImplyLeading: false),
        bottomNavigationBar: bottomNavigationBar(context, 0),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(11),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: allSkillDevelopment.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: EdgeInsets.all(5),
                          child: Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SelectedSkillScreen(
                                          selectedSkill:
                                              allSkillDevelopment[index])));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white),
                                child: Row(children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.09,
                                    child: allSkillDevelopment[index]
                                            .assetPath
                                            .isNotEmpty
                                        ? Image.asset(
                                            allSkillDevelopment[index]
                                                .assetPath,
                                            scale: .25,
                                          )
                                        : Icon(Icons.star, color: Colors.black),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: Text(
                                          allSkillDevelopment[index].skillName,
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17))),
                                    ),
                                  )
                                ])),
                          ));
                    })));
  }
}
