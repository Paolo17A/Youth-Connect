import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/screens/self_identification_answered_questions_screen.dart';

class SelfIdentificationAnsweredCategoriesScreen extends StatefulWidget {
  final Map<dynamic, dynamic> userAnswers;
  const SelfIdentificationAnsweredCategoriesScreen(
      {super.key, required this.userAnswers});

  @override
  State<SelfIdentificationAnsweredCategoriesScreen> createState() =>
      SelfIdentificationAnsweredCategoriesScreenState();
}

class SelfIdentificationAnsweredCategoriesScreenState
    extends State<SelfIdentificationAnsweredCategoriesScreen> {
  List<dynamic> answeredCategories = [];
  @override
  void initState() {
    super.initState();
    answeredCategories = widget.userAnswers.keys.toList();
    answeredCategories.removeAt(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 149, 184, 218),
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
                padding: EdgeInsets.all(11),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'Self-Identification',
                        style: GoogleFonts.notoSans(
                            textStyle: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: answeredCategories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: EdgeInsets.all(5),
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) =>
                                              SelfIdentificationAnsweredQuestionsScreen(
                                                  answeredCategory:
                                                      answeredCategories[index],
                                                  userAnsweredQuestions:
                                                      widget.userAnswers[
                                                          answeredCategories[
                                                              index]])));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Text(answeredCategories[index],
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20))),
                                    )),
                              ));
                        }),
                  ],
                )),
          ),
        ));
  }
}
