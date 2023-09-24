import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ywda/models/skill_development_model.dart';

class SubmittesSubskillResultScreen extends StatelessWidget {
  final SubSkillModel thisSubskill;
  final Map<dynamic, dynamic> submittedSubskill;
  const SubmittesSubskillResultScreen(
      {super.key, required this.thisSubskill, required this.submittedSubskill});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(thisSubskill.subSkillName,
                overflow: TextOverflow.ellipsis)),
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
          if (submittedSubskill['status'] != 'PENDING')
            Text('Grade: ${submittedSubskill['grade']}',
                style: TextStyle(fontSize: 20)),
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
                      child: Text(submittedSubskill['essayURL'],
                          style: TextStyle(fontSize: 15))),
                ))
        ])));
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
