import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnswerSurveyScreen extends StatefulWidget {
  const AnswerSurveyScreen({super.key});

  @override
  State<AnswerSurveyScreen> createState() => _AnswerSurveyScreenState();
}

class _AnswerSurveyScreenState extends State<AnswerSurveyScreen> {
  bool _isLoading = true;

  //  Survey Variables
  List<dynamic> surveyQuestions = [];
  String surveyID = '';
  List<TextEditingController> surveyControllers = [];

  @override
  void initState() {
    super.initState();
    getSurveyOnline();
  }

  @override
  void dispose() {
    super.dispose();
    for (var controller in surveyControllers) {
      controller.dispose();
    }
  }

  void getSurveyOnline() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final surveys = await FirebaseFirestore.instance
          .collection('surveys')
          .orderBy('dateAdded', descending: true)
          .get();

      surveyID = surveys.docs.first.id;
      surveyQuestions = surveys.docs.first.data()['questions'];
      print('Survey Questions: ${surveyQuestions}');
      for (int i = 0; i < surveyQuestions.length; i++) {
        surveyControllers.add(TextEditingController());
      }

      final currentUserData = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      Map<dynamic, dynamic> surveyAnswers =
          currentUserData.data()!['surveyAnswers'];
      if (surveyAnswers.containsKey(surveyID)) {
        List<dynamic> answers = surveyAnswers[surveyID];
        for (int i = 0; i < answers.length; i++) {
          surveyControllers[i].text = answers[i] as String;
        }
      }
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error getting current survey: $error')));
      setState(() {
        _isLoading = false;
      });
    }
  }

  void submitSurvey() async {
    for (int i = 0; i < surveyControllers.length; i++) {
      if (surveyControllers[i].text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please answer all survey questions.')));
        return;
      }
    }
    try {
      setState(() {
        _isLoading = true;
      });
      //  Get current user data
      final currentUserData = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      Map<dynamic, dynamic> surveyAnswers = {};
      //  Initialize surveyAnswers parameter if it doesn't exist yet. If it exists, get it's value and store it in local surveyAnswers list
      if (!currentUserData.data()!.containsKey('surveyAnswers')) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'surveyAnswers': surveyAnswers});
      } else {
        surveyAnswers = currentUserData.data()!['surveyAnswers'];
      }

      //  Collate all inputted answers in the text controllers and add it to the local surveyAnswers list.
      List<dynamic> answersToSubmit = [];
      for (int i = 0; i < surveyControllers.length; i++) {
        answersToSubmit.add(surveyControllers[i].text.trim());
      }
      surveyAnswers[surveyID] = answersToSubmit;

      //  Add the updated local surveyAnswers list to Firebase
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'surveyAnswers': surveyAnswers});

      //  Display success messages and return to self-assessment screen
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
              'Successfully submitted self-identification survey!')));
      Navigator.popAndPushNamed(context, '/assessment');
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting survey: $error')));
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
              title: Text('SELF IDENTIFICATION',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontWeight: FontWeight.bold)))),
          body: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: surveyQuestions.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(surveyQuestions[index]['question'],
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold))),
                                  TextField(
                                      controller: surveyControllers[index],
                                      keyboardType: surveyQuestions[index]
                                                  ['questionType'] ==
                                              'ESSAY'
                                          ? TextInputType.multiline
                                          : TextInputType.number,
                                      maxLines:
                                          surveyQuestions[index]['questionType'] == 'ESSAY'
                                              ? 5
                                              : 1,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1)),
                                          contentPadding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 10)))
                                ],
                              ),
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: submitSurvey,
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                child: Text('SUBMIT')),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
    );
  }
}
