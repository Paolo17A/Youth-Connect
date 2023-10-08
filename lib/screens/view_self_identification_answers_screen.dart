import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ywda/models/self_identification_model.dart';
import 'package:ywda/widgets/custom_textfield_widget.dart';

class ViewSelfIdentificationAnswerScreen extends StatefulWidget {
  final String category;
  final String question;
  final String answer;
  final DateTime dateAnswered;
  const ViewSelfIdentificationAnswerScreen(
      {super.key,
      required this.category,
      required this.question,
      required this.answer,
      required this.dateAnswered});

  @override
  State<ViewSelfIdentificationAnswerScreen> createState() =>
      _ViewSelfIdentificationAnswerScreenState();
}

class _ViewSelfIdentificationAnswerScreenState
    extends State<ViewSelfIdentificationAnswerScreen> {
  final _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _answerController.text = widget.answer;
  }

  @override
  void dispose() {
    super.dispose();
    _answerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                      image: AssetImage('lib/assets/images/icons/si_bg.jpg'),
                      fit: BoxFit.cover)),
            ),
          ),
          Positioned(
            bottom: -135,
            left: -150,
            child: Image.asset('lib/assets/images/icons/self.png', scale: 0.9),
          ),
          Padding(
            padding: EdgeInsets.all(22),
            child: Column(
              children: [
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
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                      widget.category == allSelfIdentification[0].category
                          ? 'Self-Identification'
                          : widget.category,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.satisfy(
                          textStyle: TextStyle(fontSize: 32))),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.88,
                  child: Text(widget.question,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(fontSize: 21))),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Text(
                          'Date Answered: ${DateFormat('dd MMM yyyy').format(widget.dateAnswered)}',
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 15)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: selfIdentificationTextField('Display Answer...',
                      _answerController, TextInputType.multiline, true),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
