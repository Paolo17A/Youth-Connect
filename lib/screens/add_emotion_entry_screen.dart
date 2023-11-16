import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/widgets/custom_buttons_widgets.dart';
import 'package:ywda/widgets/custom_containers_widget.dart';
import 'package:ywda/widgets/custom_textfield_widget.dart';

import '../utils/instruction_dialogue_util.dart';

class AddEmotionEntry extends StatefulWidget {
  const AddEmotionEntry({super.key});

  @override
  State<AddEmotionEntry> createState() => _AddEmotionEntryState();
}

class _AddEmotionEntryState extends State<AddEmotionEntry> {
  bool _isLoading = false;
  String _selectedEmotion = '';
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  String _getEmotionCloudPath() {
    if (_selectedEmotion == 'HAPPY') {
      return 'lib/assets/images/emotions/happiness.png';
    }
    if (_selectedEmotion == 'ANGRY') {
      return 'lib/assets/images/emotions/anger.png';
    }
    if (_selectedEmotion == 'BORED') {
      return 'lib/assets/images/emotions/bored.png';
    }
    if (_selectedEmotion == 'IDK') {
      return 'lib/assets/images/emotions/Idk what to feel.png';
    }
    if (_selectedEmotion == 'SAD') {
      return 'lib/assets/images/emotions/sadness.png';
    }
    if (_selectedEmotion == 'STRESS') {
      return 'lib/assets/images/emotions/stress.png';
    }
    return 'lib/assets/images/emotions/null.png';
  }

  void addEmotionalEntry() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    if (_selectedEmotion.isEmpty) {
      scaffoldMessenger
          .showSnackBar(SnackBar(content: Text('Please select an emotion')));
      return;
    }
    if (_descriptionController.text.isEmpty) {
      scaffoldMessenger.showSnackBar(SnackBar(
          content:
              Text('Please input a descripion for your current emotion.')));
      return;
    }
    try {
      setState(() {
        _isLoading = true;
      });
      final user = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      final userData = user.data() as Map<dynamic, dynamic>;
      Map<dynamic, dynamic> emotionTracker = userData['emotionTracker'];
      String emotionEntryID = DateTime.now().millisecondsSinceEpoch.toString();
      Map<dynamic, dynamic> newEmotionalEntry = {
        'emotion': _selectedEmotion,
        'description': _descriptionController.text.trim(),
        'dateTime': DateTime.now()
      };
      emotionTracker[emotionEntryID] = newEmotionalEntry;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'emotionTracker': emotionTracker});
      scaffoldMessenger.showSnackBar(SnackBar(
          content: Text('Successfully added new emotional tracker entry.')));
      navigator.pop();
      navigator.popAndPushNamed('/mentalHealth');
    } catch (error) {
      scaffoldMessenger.showSnackBar(SnackBar(
          content: Text('Error Adding Emotional Tracker Entry: $error')));
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
        body: switchedLoadingContainer(
            _isLoading,
            SingleChildScrollView(
              child: Stack(
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
                    bottom: 0,
                    right: 0,
                    child:
                        Image.asset('lib/assets/images/icons/mh.png', scale: 1),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          Gap(30),
                          _topRowIcons(),
                          _emotionalTrackerHeader(),
                          _emotionalCloud(),
                          _descriptionTextField(),
                          submitSelfAssessmentEntry(
                              label: 'SUBMIT',
                              onPress: () => addEmotionalEntry())
                        ],
                      ))
                ],
              ),
            )),
      ),
    );
  }

  Widget _topRowIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back)),
        Row(
          children: [
            IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed('/emotionTracker'),
                icon: Image.asset('lib/assets/images/icons/brain.png')),
            IconButton(
                onPressed: () {
                  selfAssessmentInstructionDialogue(
                      context,
                      'Share your Feelings today by choosing your dominant emotion and explain why you feel that way. You can track your daily emotions.',
                      'Press the cloud to select an emotion',
                      height: MediaQuery.of(context).size.height * 0.4);
                },
                icon: Icon(Icons.help_outline_rounded)),
          ],
        )
      ],
    );
  }

  Widget _emotionalTrackerHeader() {
    return Text('Emotional Tracker',
        style: GoogleFonts.satisfy(
            textStyle: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black)));
  }

  Widget _emotionalCloud() {
    return GestureDetector(
      onTap: () => showEmotionSelectionDialog(),
      child: Image.asset(_getEmotionCloudPath(), scale: 3),
    );
  }

  Widget _descriptionTextField() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.2),
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 219, 219, 219)),
      child: customTextField(
          'Type Here...', _descriptionController, TextInputType.multiline),
    );
  }

  void showEmotionSelectionDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            content: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Column(
                  children: [
                    ListTile(
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset('lib/assets/images/emotions/anger.png',
                                scale: 10),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Center(child: Text('ANGRY'))),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          setState(() {
                            _selectedEmotion = 'ANGRY';
                          });
                        }),
                    ListTile(
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset('lib/assets/images/emotions/bored.png',
                                scale: 10),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Center(child: Text('BORED'))),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          setState(() {
                            _selectedEmotion = 'BORED';
                          });
                        }),
                    ListTile(
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                                'lib/assets/images/emotions/happiness.png',
                                scale: 10),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Center(child: Text('HAPPY'))),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          setState(() {
                            _selectedEmotion = 'HAPPY';
                          });
                        }),
                    ListTile(
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                                'lib/assets/images/emotions/Idk what to feel.png',
                                scale: 10),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Center(child: Text('IDK WHAT TO FEEL'))),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          setState(() {
                            _selectedEmotion = 'IDK';
                          });
                        }),
                    ListTile(
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                                'lib/assets/images/emotions/sadness.png',
                                scale: 10),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Center(child: Text('SAD'))),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          setState(() {
                            _selectedEmotion = 'SAD';
                          });
                        }),
                    ListTile(
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset('lib/assets/images/emotions/stress.png',
                                scale: 10),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Center(child: Text('STRESS'))),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          setState(() {
                            _selectedEmotion = 'STRESS';
                          });
                        }),
                  ],
                ),
              ),
            )));
  }
}
