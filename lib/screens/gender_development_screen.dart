import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/widgets/custom_buttons_widgets.dart';

class GenderDevelopmentScreen extends StatelessWidget {
  const GenderDevelopmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 149, 184, 218),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('The Gender Bread Person',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 27,
                          fontWeight: FontWeight.bold))),
              Image.asset('lib/assets/images/icons/Gender Bread.png'),
              genderDevelopmentButton('START', () {
                Navigator.of(context).pushReplacementNamed('/editGender');
              })
            ],
          ),
        )));
  }
}
