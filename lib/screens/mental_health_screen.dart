import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/widgets/custom_buttons_widgets.dart';
import 'package:ywda/widgets/custom_styling_widgets.dart';

class MentalHealthScreen extends StatelessWidget {
  const MentalHealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 149, 184, 218),
      body: SafeArea(
          child: allPadding8Pix(Column(
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
          selfAssessmentButton('', 'Emotional Tracker: My Feelings', () {},
              size: 18),
          selfAssessmentButton(
              'lib/assets/images/icons/lusog-isip.png',
              'Lusog Isip',
              () => Navigator.of(context).pushNamed('/lusogIsip')),
        ],
      ))),
    );
  }
}
