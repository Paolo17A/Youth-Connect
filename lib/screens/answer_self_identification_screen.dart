import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/models/self_identification_model.dart';
import 'package:ywda/widgets/custom_textfield_widget.dart';

class AnswerSelfIdentificationScreen extends StatefulWidget {
  final String category;
  final String question;
  final int questionIndex;
  const AnswerSelfIdentificationScreen(
      {super.key,
      required this.category,
      required this.question,
      required this.questionIndex});

  @override
  State<AnswerSelfIdentificationScreen> createState() =>
      _AnswerPrereqScreenState();
}

class _AnswerPrereqScreenState extends State<AnswerSelfIdentificationScreen> {
  bool _isLoading = false;
  final _answerController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _answerController.dispose();
  }

  void _submitAnswer() async {
    print('SUBMITTING');
    FocusScope.of(context).unfocus();
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    if (_answerController.text.isEmpty || _answerController.text.length < 20) {
      scaffoldMessenger.showSnackBar(const SnackBar(
          content: Text(
              'Please input an entry that is at least 20 characters long.')));
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });

      final currentUserData = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      final selfIdentificationData = currentUserData
          .data()!['selfIdentification'] as Map<dynamic, dynamic>;

      if (selfIdentificationData.containsKey(widget.category)) {
        selfIdentificationData[widget.category][widget.question] = {
          'answer': _answerController.text.trim(),
          'dateAdded': DateTime.now()
        };
      } else {
        selfIdentificationData[widget.category] = {
          widget.question: {
            'answer': _answerController.text.trim(),
            'dateAdded': DateTime.now()
          }
        };
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'selfIdentification': selfIdentificationData});

      setState(() {
        _isLoading = false;
      });
      scaffoldMessenger.showSnackBar(SnackBar(
          content: Text('Successfully added self identification entry.')));
      navigator.pop();
      navigator.pushReplacementNamed(
          widget.category == allSelfIdentification[0].category
              ? '/selfIdentification'
              : '/selfIdentificationCategory');
    } catch (error) {
      scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Error submitting your answer: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
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
              child:
                  Image.asset('lib/assets/images/icons/self.png', scale: 0.9),
            ),
            Padding(
              padding: EdgeInsets.all(22),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.all(4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'lib/assets/images/icons/icon-edit.png',
                            scale: 2,
                          ),
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
                  Row(
                    children: [
                      Text('Question #${widget.questionIndex.toString()}',
                          style: GoogleFonts.sarala(
                              textStyle:
                                  TextStyle(fontSize: 16, color: Colors.grey))),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: selfIdentificationTextField(
                        'Type your answer here...',
                        _answerController,
                        TextInputType.multiline,
                        false),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 19),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              _submitAnswer();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 175, 210, 244),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40))),
                            child: Text('SUBMIT',
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18))))
                      ],
                    ),
                  )
                ],
              ),
            ),
            if (_isLoading)
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        )),
      ),
    );
  }
}
