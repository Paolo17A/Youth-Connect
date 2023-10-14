import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/models/skill_development_model.dart';
import 'package:ywda/utils/badge_couter_util.dart';
import 'package:ywda/widgets/custom_styling_widgets.dart';

class SkillLeaderboardScreen extends StatefulWidget {
  final SkillDevelopmentModel selectedSkill;
  const SkillLeaderboardScreen({super.key, required this.selectedSkill});

  @override
  State<SkillLeaderboardScreen> createState() => _SkillLeaderboardScreenState();
}

class _SkillLeaderboardScreenState extends State<SkillLeaderboardScreen> {
  bool _isLoading = true;
  bool _isInitialized = false;
  List<DocumentSnapshot> eligibleUsers = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getEligibleUsers();
  }

  Future getEligibleUsers() async {
    if (_isInitialized) {
      return;
    }
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final users = await FirebaseFirestore.instance
          .collection('users')
          .where('userType', isEqualTo: 'CLIENT')
          .get();
      final userDocs = users.docs;
      eligibleUsers = userDocs.where((doc) {
        final userData = doc.data();
        return userData.containsKey('skillsDeveloped') &&
            (userData['skillsDeveloped'] as Map<dynamic, dynamic>).isNotEmpty &&
            (userData['skillsDeveloped'] as Map<dynamic, dynamic>)
                .containsKey(widget.selectedSkill.skillName) &&
            countSkillBadges(userData['skillsDeveloped']
                    [widget.selectedSkill.skillName]) !=
                0;
      }).toList();
      setState(() {
        _isLoading = false;
        _isInitialized = true;
      });
    } catch (error) {
      scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Error getting eligible users: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.asset('lib/assets/images/icons/icons-ranking.png'),
                      Container(
                        height: 75,
                        decoration: decorationWithShadow(),
                        child: Center(
                            child: Text(widget.selectedSkill.skillName,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26)))),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: SingleChildScrollView(
                            child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.70,
                          child: eligibleUsers.isNotEmpty
                              ? Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.2,
                                            child: Text('RANKING',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.notoSans(
                                                    textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15)))),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          child: Text('NAME',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.notoSans(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15))),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          child: Text('MEDALS',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.notoSans(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15))),
                                        )
                                      ],
                                    ),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: eligibleUsers.length,
                                        itemBuilder: (context, index) {
                                          final userData = eligibleUsers[index]
                                              .data()! as Map<dynamic, dynamic>;
                                          return Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 115, 146, 175),
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                    child: Text('${index + 1}',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: GoogleFonts.poly(
                                                            textStyle: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    30)))),
                                                SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.45,
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundColor:
                                                                Colors.white,
                                                            radius: 27,
                                                            child: Icon(
                                                                Icons.person),
                                                          ),
                                                          Text(
                                                            userData[
                                                                'fullName'],
                                                            style: GoogleFonts.notoSans(
                                                                textStyle: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          )
                                                        ])),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  child: Text(
                                                      countSkillBadges(userData[
                                                                  'skillsDeveloped']
                                                              [widget
                                                                  .selectedSkill
                                                                  .skillName])
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.poly(
                                                          textStyle: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 26))),
                                                )
                                              ],
                                            ),
                                          );
                                        }),
                                  ],
                                )
                              : Center(
                                  child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    'NO ELIGIBLE USERS AVAILABLE',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 36,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                )),
                        )),
                      )
                    ],
                  ),
                )),
    );
  }
}
