import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/models/skill_development_model.dart';
import 'package:ywda/screens/selected_subskill_screen.dart';

class SelectedSkillScreen extends StatelessWidget {
  final SkillDevelopmentModel selectedSkill;
  const SelectedSkillScreen({super.key, required this.selectedSkill});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              selectedSkill.assetPath.isNotEmpty
                  ? Transform.scale(
                      scale: 0.8, child: Image.asset(selectedSkill.assetPath))
                  : Icon(Icons.star, color: Colors.black),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .55,
                  child: Text(selectedSkill.skillName,
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
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: selectedSkill.subSkills.map((subskill) {
                    return Container(
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.55,
                                  child: Text(subskill.subSkillName,
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20))),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SelectedSubskillScreen(
                                                        selectedSubskill:
                                                            subskill)));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30))),
                                      child: Text('Start',
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold))),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ))),
    );
  }
}
