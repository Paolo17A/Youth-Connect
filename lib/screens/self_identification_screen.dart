import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/models/self_identification_model.dart';
import 'package:ywda/screens/answer_self_identification_screen.dart';
import 'package:ywda/screens/self_identification_answered_categories_screen.dart';
import 'package:ywda/screens/view_self_identification_answers_screen.dart';

class SelfIdentificationScreen extends StatefulWidget {
  const SelfIdentificationScreen({super.key});

  @override
  State<SelfIdentificationScreen> createState() =>
      _SelfIdentificationScreenState();
}

class _SelfIdentificationScreenState extends State<SelfIdentificationScreen> {
  bool _isLoading = true;
  bool _preRequisitesDone = true;
  bool _allQuestionsAnswered = false;
  Map<dynamic, dynamic> selfIdentity = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getSelfIdentificationData();
  }

  void getSelfIdentificationData() async {
    try {
      final currentUserData = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (currentUserData.data()!.containsKey('selfIdentification')) {
        selfIdentity = currentUserData.data()!['selfIdentification'];
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'selfIdentification': selfIdentity});
      }

      if (selfIdentity.containsKey(allSelfIdentification[0].category) &&
          (selfIdentity[allSelfIdentification[0].category]
                      as Map<dynamic, dynamic>)
                  .length ==
              allSelfIdentification[0].questions.length) {
        _preRequisitesDone = true;
      } else {
        _preRequisitesDone = false;
      }

      if (selfIdentity.containsKey(
              allSelfIdentification[allSelfIdentification.length - 1]
                  .category) &&
          (selfIdentity[allSelfIdentification[allSelfIdentification.length - 1]
                      .category] as Map<dynamic, dynamic>)
                  .length ==
              allSelfIdentification[allSelfIdentification.length - 1]
                  .questions
                  .length) {
        _allQuestionsAnswered = true;
      }
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error getting self identification data: $error')));
    }
  }

  bool containsThisPrerequisite(String prereq) {
    if (selfIdentity.isEmpty ||
        !selfIdentity.containsKey(allSelfIdentification[0].category)) {
      return false;
    }

    if ((selfIdentity[allSelfIdentification[0].category]
            as Map<dynamic, dynamic>)
        .containsKey(prereq)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 132, 171, 207),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Self-Identification',
                            style: GoogleFonts.notoSansBengali(
                                textStyle: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black))),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              image: DecorationImage(
                                  image: AssetImage(
                                      'lib/assets/images/icons/si_bg-portrait.jpg'),
                                  fit: BoxFit.cover)),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Text(
                                      'Answer the questions before we start.',
                                      style: GoogleFonts.notoSansBengali(
                                          textStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold))),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: allSelfIdentification[0]
                                          .questions
                                          .length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            if (containsThisPrerequisite(
                                                allSelfIdentification[0]
                                                    .questions[index])) {
                                              String _selectedCategory =
                                                  allSelfIdentification[0]
                                                      .category;
                                              String _selectedQuestion =
                                                  allSelfIdentification[0]
                                                      .questions[index];

                                              String thisAnswer = (selfIdentity[
                                                              _selectedCategory]
                                                          [_selectedQuestion]
                                                      as Map<dynamic, dynamic>)[
                                                  'answer'];
                                              Timestamp dateAdded = (selfIdentity[
                                                              _selectedCategory]
                                                          [_selectedQuestion]
                                                      as Map<dynamic, dynamic>)[
                                                  'dateAdded'] as Timestamp;
                                              Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      ViewSelfIdentificationAnswerScreen(
                                                          category:
                                                              _selectedCategory,
                                                          question:
                                                              _selectedQuestion,
                                                          answer: thisAnswer,
                                                          dateAnswered:
                                                              dateAdded
                                                                  .toDate())));
                                            } else {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AnswerSelfIdentificationScreen(
                                                            category:
                                                                allSelfIdentification[
                                                                        0]
                                                                    .category,
                                                            question:
                                                                allSelfIdentification[
                                                                            0]
                                                                        .questions[
                                                                    index],
                                                            questionIndex:
                                                                index + 1,
                                                          )));
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4),
                                            child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                height: 70,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text('#${index + 1}',
                                                        style: GoogleFonts.novaScript(
                                                            textStyle: TextStyle(
                                                                color: containsThisPrerequisite(allSelfIdentification[0]
                                                                            .questions[
                                                                        index])
                                                                    ? Color
                                                                        .fromARGB(
                                                                            255,
                                                                            34,
                                                                            52,
                                                                            189)
                                                                    : Colors
                                                                        .grey,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 23))),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 15),
                                                      child: SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.55,
                                                        child: Text(
                                                          allSelfIdentification[
                                                                  0]
                                                              .questions[index],
                                                          style: GoogleFonts
                                                              .notoSerif(),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )),
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                        ),
                        if (!_allQuestionsAnswered)
                          SizedBox(
                              child: ElevatedButton(
                                  onPressed: _preRequisitesDone
                                      ? () {
                                          Navigator.pushReplacementNamed(
                                              context,
                                              '/selfIdentificationCategory');
                                        }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 34, 52, 189),
                                      disabledBackgroundColor: Colors.grey,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: Text('START',
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30))),
                                  ))),
                        if (_preRequisitesDone &&
                            selfIdentity
                                .containsKey(allSelfIdentification[1].category))
                          SizedBox(
                            width: 230,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          SelfIdentificationAnsweredCategoriesScreen(
                                              userAnswers: selfIdentity)));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 34, 52, 189),
                                    disabledBackgroundColor: Colors.grey,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40))),
                                child: Text('VIEW PREVIOUS ANSWERS',
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)))),
                          )
                      ],
                    ),
                  ),
                )));
  }
}
