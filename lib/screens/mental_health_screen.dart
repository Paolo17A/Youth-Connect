import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/widgets/custom_buttons_widgets.dart';
import 'package:ywda/widgets/custom_containers_widget.dart';
import 'package:ywda/widgets/custom_styling_widgets.dart';

class MentalHealthScreen extends StatefulWidget {
  const MentalHealthScreen({super.key});

  @override
  State<MentalHealthScreen> createState() => _MentalHealthScreenState();
}

class _MentalHealthScreenState extends State<MentalHealthScreen> {
  bool _isLoading = true;
  bool _hasEmotionEntryToday = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getEmotionalHistory();
  }

  void getEmotionalHistory() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final user = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      final userData = user.data() as Map<dynamic, dynamic>;
      final Map<dynamic, dynamic> emotionTracker = userData['emotionTracker'];
      for (var emotion in emotionTracker.entries) {
        final emotionMap = emotion.value as Map<String, dynamic>;
        final emotionDate = (emotionMap['dateTime'] as Timestamp).toDate();
        if (_isDateEqual(DateTime.now(), emotionDate)) {
          _hasEmotionEntryToday = true;
          break;
        }
      }

      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Error getting Emotional History: $error')));
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool _isDateEqual(DateTime _selectedDate, DateTime _workoutDate) {
    return _selectedDate.year == _workoutDate.year &&
        _selectedDate.month == _workoutDate.month &&
        _selectedDate.day == _workoutDate.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 149, 184, 218),
      body: SafeArea(
          child: switchedLoadingContainer(
        _isLoading,
        allPadding8Pix(Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 35),
              child: Text('Mental Health',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 27,
                          fontWeight: FontWeight.bold))),
            ),
            selfAssessmentButton('', 'Emotional Tracker: My Feelings', () {
              if (_hasEmotionEntryToday) {
                Navigator.of(context).pushNamed('/emotionTracker');
              } else {
                Navigator.of(context).pushNamed('/addEmotion');
              }
            }, size: 18),
            selfAssessmentButton(
                'lib/assets/images/icons/lusog-isip.png',
                'Lusog Isip',
                () => Navigator.of(context).pushNamed('/lusogIsip')),
          ],
        )),
      )),
    );
  }
}
