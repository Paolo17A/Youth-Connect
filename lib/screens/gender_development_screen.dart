import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/utils/url_util.dart';
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('The Gender Bread Person',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 27,
                              fontWeight: FontWeight.bold))),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child:
                        Image.asset('lib/assets/images/icons/Gender Bread.png'),
                  ),
                  genderDevelopmentButton('START', () {
                    Navigator.of(context).pushReplacementNamed('/editGender');
                  }),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () => launchThisURL(
                              'https://www.itspronouncedmetrosexual.com/'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                          child: Text(
                            'Press here for a bigger bite',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ))),
                )
              ])
            ],
          ),
        )));
  }
}
