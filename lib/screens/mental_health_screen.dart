import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class MentalHealthScreen extends StatelessWidget {
  const MentalHealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 242, 245),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(children: [
                  Image.asset('lib/assets/images/icons/DOH-logo.png',
                      scale: 3.5),
                  const SizedBox(width: 30),
                  Image.asset('lib/assets/images/icons/lusog-isip.png',
                      scale: 1.5)
                ]),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                          'Lusog-Isip is the first mobile app for mental health and self-care culturally adopted for the Philippines. It uses evidence-based screening tools and interventions to help you on your journey towards better overall well-being and healthier coping strategies.',
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)))),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 250,
                            child: ElevatedButton(
                                onPressed: () async {
                                  final url = Uri.parse(
                                      'https://play.google.com/store/apps/details?id=ph.gov.doh.lusogisip&hl=en&gl=US');
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url);
                                  } else {
                                    // Handle the case where the URL cannot be launched
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Unable to open Play Store.')));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.asset(
                                        'lib/assets/images/icons/android.png'),
                                    Text('Download APK',
                                        style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black))),
                                  ],
                                )),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: 250,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () async {
                                  final url =
                                      Uri.parse('https://lusog-isip.ph/');
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url);
                                  } else {
                                    // Handle the case where the URL cannot be launched
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('Unable to open Link.')));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                child: Text('Visit Website',
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)))),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
