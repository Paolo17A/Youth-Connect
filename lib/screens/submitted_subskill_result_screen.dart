import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ywda/models/skill_development_model.dart';
import 'package:ywda/screens/selected_subskill_screen.dart';

class SubmittesSubskillResultScreen extends StatelessWidget {
  final SkillDevelopmentModel thisSkill;
  final SubSkillModel thisSubskill;
  final Map<dynamic, dynamic> submittedSubskill;
  final String remarks;
  const SubmittesSubskillResultScreen(
      {super.key,
      required this.thisSkill,
      required this.thisSubskill,
      required this.submittedSubskill,
      required this.remarks});

  void retakeQuiz(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return SelectedSubskillScreen(
          selectedSkill: thisSkill, selectedSubskill: thisSubskill);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text(thisSubskill.subSkillName, overflow: TextOverflow.ellipsis),
          actions: [
            if (submittedSubskill['status'] == 'DENIED' ||
                (submittedSubskill['status'] == 'GRADED' &&
                    submittedSubskill['grade'] != 3))
              TextButton(
                  onPressed: () {
                    retakeQuiz(context);
                  },
                  child: Text('RETAKE',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16))))
          ],
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Text(
                  'STATUS: ${(submittedSubskill['status']).toString().toUpperCase()}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            ),
          ),
          if (submittedSubskill['status'] == 'GRADED')
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Grade:',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(fontSize: 25))),
                if (submittedSubskill['grade'] == 1)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                        'lib/assets/images/icons/icons-beginner.png',
                        scale: 10),
                  ),
                if (submittedSubskill['grade'] == 2)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                        'lib/assets/images/icons/icons-novice.png',
                        scale: 10),
                  ),
                if (submittedSubskill['grade'] == 3)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('lib/assets/images/icons/icons-pro.png',
                        scale: 10),
                  )
              ],
            ),
          const SizedBox(height: 30),
          Text(
              thisSubskill.requiredTaskType == TaskType.VIDEO
                  ? submittedSubskill['videoTitle']
                  : submittedSubskill['essayTitle'],
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          if (thisSubskill.requiredTaskType == TaskType.VIDEO)
            GestureDetector(
                onTap: () => _launchURL(submittedSubskill['videoURL']),
                child: Text(submittedSubskill['videoURL'],
                    style: TextStyle(decoration: TextDecoration.underline)))
          else if (thisSubskill.requiredTaskType == TaskType.ESSAY)
            Container(
                height: 500,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(11),
                  child: SingleChildScrollView(
                      child: Text(submittedSubskill['essayContent'],
                          style: TextStyle(fontSize: 15))),
                )),
          if (remarks.isNotEmpty) _remarksWidget(context)
        ])));
  }

  Widget _remarksWidget(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 90),
        Text('Remarks',
            style: GoogleFonts.poppins(
                textStyle: TextStyle(color: Colors.black, fontSize: 28))),
        Container(
            height: 250,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(11),
              child: SingleChildScrollView(
                  child: Text(remarks, style: TextStyle(fontSize: 15))),
            ))
      ],
    );
  }

  _launchURL(String _url) async {
    final url = Uri.parse(_url);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      // Handle the case where the URL cannot be launched
      print('Could not launch $url');
    }
  }
}
