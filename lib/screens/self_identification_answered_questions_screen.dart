import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/screens/view_self_identification_answers_screen.dart';

class SelfIdentificationAnsweredQuestionsScreen extends StatefulWidget {
  final String answeredCategory;
  final Map<dynamic, dynamic> userAnsweredQuestions;
  const SelfIdentificationAnsweredQuestionsScreen(
      {super.key,
      required this.answeredCategory,
      required this.userAnsweredQuestions});

  @override
  State<SelfIdentificationAnsweredQuestionsScreen> createState() =>
      SelfIdentificationAnsweredQuestionsScreenState();
}

class SelfIdentificationAnsweredQuestionsScreenState
    extends State<SelfIdentificationAnsweredQuestionsScreen> {
  List<dynamic> answeredQuestions = [];
  @override
  void initState() {
    super.initState();
    answeredQuestions = widget.userAnsweredQuestions.keys.toList();
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
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Padding(
                          padding: EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'X',
                                    style: GoogleFonts.pontanoSans(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold)),
                                  ))
                            ],
                          )),
                    ]),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        widget.answeredCategory,
                        style: GoogleFonts.notoSans(
                            textStyle: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: answeredQuestions.length,
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
                                              ViewSelfIdentificationAnswerScreen(
                                                  category:
                                                      widget.answeredCategory,
                                                  question:
                                                      answeredQuestions[index],
                                                  answer: widget
                                                              .userAnsweredQuestions[
                                                          answeredQuestions[index]]
                                                      ['answer'],
                                                  dateAnswered: widget
                                                      .userAnsweredQuestions[
                                                          answeredQuestions[index]]
                                                          ['dateAdded']
                                                      .toDate())));
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Text(answeredQuestions[index],
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15))),
                                    )),
                              ));
                        }),
                  ],
                )),
          ),
        ));
  }
}
