import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/app_bottom_navbar_widget.dart';

class SelfAssessmentScreen extends StatelessWidget {
  const SelfAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, ModalRoute.withName('/home'));
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: [
              Transform.scale(
                scale: 1.5,
                child: IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                        'lib/assets/images/icons/icons-ranking.png')),
              )
            ],
          ),
          bottomNavigationBar: bottomNavigationBar(context, 0),
          body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        _selfAssessmentButton(
                            'lib/assets/images/icons/icons-creativity.png',
                            'SKILLS DEVELOPMENT', () {
                          Navigator.of(context).pushNamed('/skills');
                        }),
                        _selfAssessmentButton(
                            'lib/assets/images/icons/Bread.png',
                            'GENDER DEVELOPMENT',
                            () {}),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 90),
                        _selfAssessmentButton(
                            'lib/assets/images/icons/icons-brain.png',
                            'MENTAL HEALTH', () async {
                          final url = Uri.parse(
                              'https://play.google.com/store/apps/details?id=ph.gov.doh.lusogisip&hl=en&gl=US');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            // Handle the case where the URL cannot be launched
                            print('Could not launch $url');
                          }
                        }),
                        _selfAssessmentButton(
                            'lib/assets/images/icons/Self Identification.png',
                            'SELF IDENTIFICATION',
                            () {}),
                      ],
                    )
                  ],
                )),
          )),
    );
  }

  Widget _selfAssessmentButton(
      String imagePath, String label, Function onPress) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
          width: 170,
          height: 220,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            onPressed: () {
              onPress();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    imagePath,
                    scale: .7,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(label,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
                )
              ],
            ),
          )),
    );
  }
}
