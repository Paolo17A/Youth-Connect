import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/custom_buttons_widgets.dart';
import '../widgets/custom_styling_widgets.dart';

class NewSelfIdentificationScreen extends StatelessWidget {
  const NewSelfIdentificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 149, 184, 218),
      body: SafeArea(
          child: allPadding8Pix(Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 35),
            child: Text('Self Identification',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 27,
                        fontWeight: FontWeight.bold))),
          ),
          selfAssessmentButton('', 'Twenty Statement Test',
              () => Navigator.of(context).pushNamed('/twentyStatements'),
              size: 18),
          selfAssessmentButton('', 'My Personal Shield',
              () => Navigator.of(context).pushNamed('/personalShield')),
          selfAssessmentButton('', 'Are you as Slave of Social Approval',
              () => Navigator.of(context).pushNamed('/slaveOfSocials'),
              size: 16),
          selfAssessmentButton(
              '',
              'Tolerance Test \n What is your Level of People Tolerance',
              () => Navigator.of(context).pushNamed('/toleranceTest'),
              size: 15),
        ],
      ))),
    );
  }
}
