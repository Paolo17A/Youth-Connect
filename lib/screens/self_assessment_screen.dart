import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/widgets/app_drawer_widget.dart';
import 'package:ywda/widgets/custom_containers_widget.dart';
import '../widgets/app_bottom_navbar_widget.dart';
import '../widgets/custom_buttons_widgets.dart';

class SelfAssessmentScreen extends StatefulWidget {
  const SelfAssessmentScreen({super.key});

  @override
  State<SelfAssessmentScreen> createState() => _SelfAssessmentScreenState();
}

class _SelfAssessmentScreenState extends State<SelfAssessmentScreen> {
  bool _isLoading = true;
  bool hasPersonalShieldBadge = false;
  bool hasTwentyStatementsBadge = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getBadges();
  }

  void getBadges() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final user = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      final userData = user.data() as Map<dynamic, dynamic>;
      hasPersonalShieldBadge = userData['hasPersonalShieldBadge'];
      hasTwentyStatementsBadge = userData['hasTwentyStatementsBadge'];
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Error getting badges: $error')));
      setState(() {
        _isLoading = false;
      });
    }
  }

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
            automaticallyImplyLeading: true,
            actions: [
              Transform.scale(
                scale: 1.5,
                child: IconButton(
                    onPressed: () => displayBadgesDialog(),
                    icon:
                        Image.asset('lib/assets/images/icons/blackBadge.png')),
              )
            ],
          ),
          drawer: appDrawer(context),
          bottomNavigationBar: bottomNavigationBar(context, 0),
          body: RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _isLoading = true;
                getBadges();
              });
            },
            child: switchedLoadingContainer(
                _isLoading,
                SafeArea(
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          selfAssessmentButton(
                              'lib/assets/images/icons/Bread.png',
                              'GENDER DEVELOPMENT', () {
                            Navigator.of(context)
                                .pushNamed('/genderDevelopment');
                          }, size: 18),
                          selfAssessmentButton(
                              'lib/assets/images/icons/icons-brain.png',
                              'MENTAL HEALTH', () async {
                            Navigator.of(context).pushNamed('/mentalHealth');
                          }),
                          selfAssessmentButton(
                              'lib/assets/images/icons/Self Identification.png',
                              'SELF IDENTIFICATION', () {
                            Navigator.pushNamed(
                                context, '/newSelfIdentification');
                          })
                        ],
                      )),
                )),
          )),
    );
  }

  void displayBadgesDialog() {
    showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('EARNED BADGES',
                        style:
                            GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    Gap(40),
                    if (!hasPersonalShieldBadge && !hasTwentyStatementsBadge)
                      Text('You have not yet earned any badges.',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold, fontSize: 13)),
                    if (hasPersonalShieldBadge)
                      Row(
                        children: [
                          Image.asset('lib/assets/images/icons/blackBadge.png'),
                          Text('Personal Shield Badge',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                        ],
                      ),
                    if (hasTwentyStatementsBadge)
                      Row(
                        children: [
                          Image.asset('lib/assets/images/icons/blackBadge.png'),
                          Text('Twenty Statements Badge',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                        ],
                      )
                  ],
                ),
              ),
            )));
  }
}
