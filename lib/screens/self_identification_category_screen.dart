import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/models/self_identification_model.dart';
import 'package:ywda/screens/answer_self_identification_screen.dart';
import 'package:ywda/screens/view_self_identification_answers_screen.dart';

class SelfIdentificationCategoryScreen extends StatefulWidget {
  const SelfIdentificationCategoryScreen({super.key});

  @override
  State<SelfIdentificationCategoryScreen> createState() =>
      _SelfIdentificationCategoryScreenState();
}

class _SelfIdentificationCategoryScreenState
    extends State<SelfIdentificationCategoryScreen> {
  bool _isLoading = true;
  bool _categoryComplete = true;
  Map<dynamic, dynamic> selfIdentity = {};
  int currentCategoryIndex = 0;

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

      selfIdentity = currentUserData.data()!['selfIdentification'];

      currentCategoryIndex = selfIdentity.length;
      if ((selfIdentity[allSelfIdentification[currentCategoryIndex - 1]
                  .category] as Map<dynamic, dynamic>)
              .length !=
          allSelfIdentification[currentCategoryIndex - 1].questions.length) {
        currentCategoryIndex--;
      }

      if (selfIdentity.containsKey(
              allSelfIdentification[currentCategoryIndex].category) &&
          (selfIdentity[allSelfIdentification[currentCategoryIndex].category]
                      as Map<dynamic, dynamic>)
                  .length ==
              allSelfIdentification[currentCategoryIndex].questions.length) {
        _categoryComplete = true;
      } else {
        _categoryComplete = false;
      }
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error getting self identification data: $error')));
    }
  }

  bool containsThisQuestion(String question) {
    if (!selfIdentity
        .containsKey(allSelfIdentification[currentCategoryIndex].category)) {
      return false;
    }

    if ((selfIdentity[allSelfIdentification[currentCategoryIndex].category]
            as Map<dynamic, dynamic>)
        .containsKey(question)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                          image:
                              AssetImage('lib/assets/images/icons/si_bg.jpg'),
                          fit: BoxFit.cover)),
                ),
                Positioned(
                  bottom: -135,
                  left: -150,
                  child: Image.asset('lib/assets/images/icons/self.png',
                      scale: 0.9),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: Text(
                            allSelfIdentification[currentCategoryIndex]
                                .category,
                            style: GoogleFonts.satisfy(
                                textStyle: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black))),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.2),
                            borderRadius: BorderRadius.circular(25),
                            color: Color.fromARGB(255, 219, 219, 219)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 35),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  allSelfIdentification[currentCategoryIndex]
                                      .questions
                                      .length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    if (containsThisQuestion(
                                        allSelfIdentification[
                                                currentCategoryIndex]
                                            .questions[index])) {
                                      String _selectedCategory =
                                          allSelfIdentification[
                                                  currentCategoryIndex]
                                              .category;
                                      String _selectedQuestion =
                                          allSelfIdentification[
                                                  currentCategoryIndex]
                                              .questions[index];

                                      String thisAnswer = (selfIdentity[
                                                  _selectedCategory]
                                              [_selectedQuestion]
                                          as Map<dynamic, dynamic>)['answer'];
                                      DateTime dateAdded =
                                          ((selfIdentity[_selectedCategory]
                                                          [_selectedQuestion]
                                                      as Map<dynamic, dynamic>)[
                                                  'dateAdded'] as Timestamp)
                                              .toDate();
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) =>
                                              ViewSelfIdentificationAnswerScreen(
                                                  category: _selectedCategory,
                                                  question: _selectedQuestion,
                                                  answer: thisAnswer,
                                                  dateAnswered: dateAdded)));
                                    } else {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AnswerSelfIdentificationScreen(
                                                    category: allSelfIdentification[
                                                            currentCategoryIndex]
                                                        .category,
                                                    question: allSelfIdentification[
                                                            currentCategoryIndex]
                                                        .questions[index],
                                                    questionIndex: index + 1,
                                                  )));
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(7),
                                    child: Container(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                            decoration: BoxDecoration(
                                                color: containsThisQuestion(
                                                        allSelfIdentification[
                                                                currentCategoryIndex]
                                                            .questions[index])
                                                    ? Colors.black
                                                    : null,
                                                border: Border.all(
                                                    color: Colors.black))),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: Text(
                                              allSelfIdentification[
                                                      currentCategoryIndex]
                                                  .questions[index],
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      decoration: containsThisQuestion(
                                                              allSelfIdentification[
                                                                          currentCategoryIndex]
                                                                      .questions[
                                                                  index])
                                                          ? TextDecoration
                                                              .lineThrough
                                                          : TextDecoration
                                                              .none))),
                                        )
                                      ],
                                    )),
                                  ),
                                );
                              }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 29, vertical: 19),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 110,
                              child: ElevatedButton(
                                  onPressed: _categoryComplete ? () {} : null,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 175, 210, 244),
                                      foregroundColor: Colors.black,
                                      disabledBackgroundColor:
                                          Color.fromARGB(255, 153, 165, 177),
                                      disabledForegroundColor:
                                          Color.fromARGB(255, 132, 126, 126),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40))),
                                  child: Text('NEXT',
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)))),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    ));
  }
}
