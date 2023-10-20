import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ywda/models/organization_model.dart';
import 'package:ywda/widgets/app_bottom_navbar_widget.dart';

class SelectedOrganizationScreen extends StatelessWidget {
  final OrganizationModel selectedOrg;
  const SelectedOrganizationScreen({super.key, required this.selectedOrg});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(selectedOrg.name)),
        bottomNavigationBar: bottomNavigationBar(context, 2),
        body: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 180,
                  child: Stack(
                    children: [
                      selectedOrg.coverURL.isNotEmpty
                          ? Container(
                              width: double.infinity,
                              height: 160,
                              color: Colors.white,
                              child: Image.network(
                                selectedOrg.coverURL,
                                fit: BoxFit.cover,
                              ))
                          : Container(
                              height: 160,
                              color: Colors.white,
                              child: Center(
                                  child: Text(
                                'NO COVER PHOTO AVAILABLE',
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              )),
                            ),
                      Positioned(
                        top: 80,
                        left: 10,
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadiusDirectional.circular(90),
                              child: selectedOrg.logoURL.isNotEmpty
                                  ? Image.network(selectedOrg.logoURL)
                                  : Container(
                                      color: Colors.white,
                                      child: Center(
                                        child: Text('NO IMAGE AVAILABLE',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                color: Colors.black)),
                                      ),
                                    )),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(selectedOrg.name,
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 25))),
                ),
                Divider(
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                  color: Colors.black.withOpacity(0.2),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('DETAILS',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          Text(
                            "\u2022",
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(
                            width: 10,
                          ), //space between bullet and text
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: GestureDetector(
                              onTap: () => _launchURL(selectedOrg.socMed),
                              child: Text(
                                selectedOrg.socMed.isNotEmpty
                                    ? selectedOrg.socMed
                                    : 'N/A',
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.inter(
                                    decoration: TextDecoration.underline,
                                    textStyle: const TextStyle(fontSize: 15)),
                              ),
                            ),
                          )
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          Text(
                            "\u2022",
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(
                            width: 10,
                          ), //space between bullet and text
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              'Contact Details: ${selectedOrg.contactDetails.isNotEmpty ? selectedOrg.contactDetails : 'N/A'}',
                              overflow: TextOverflow.clip,
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(fontSize: 15)),
                            ),
                          )
                        ]),
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                  color: Colors.black.withOpacity(0.2),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(selectedOrg.intro,
                      softWrap: true,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(fontSize: 16))),
                )
              ],
            )));
  }
}

_launchURL(String _url) async {
  final url = Uri.parse(_url);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    // Handle the case where the URL cannot be launched
    print('Could not launch $url');
  }
}
