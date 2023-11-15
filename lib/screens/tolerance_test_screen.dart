import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/utils/instruction_dialogue_util.dart';
import 'package:ywda/widgets/custom_containers_widget.dart';
import 'package:ywda/widgets/custom_styling_widgets.dart';

import '../widgets/custom_buttons_widgets.dart';

class ToleranceTestScreen extends StatefulWidget {
  const ToleranceTestScreen({super.key});

  @override
  State<ToleranceTestScreen> createState() => _ToleranceTestScreenState();
}

class _ToleranceTestScreenState extends State<ToleranceTestScreen> {
  bool _isLoading = true;

  List<String> toleranceTests = [
    'Learning that your friend is keeping a homosexual affair.',
    'Having a neighbor who is an alcoholic or addict.',
    'Seeing a woman in church with a low neckline. Backless blouse and Berry short skirt.',
    'Lovers kissing in public.',
    'Your boss shouting at you and calling you an idiot.',
    'Learning that a priest or nun is involved in a lab affair.',
    'Your girlfriend/boyfriend confessing to you that he had a child with a girl/ boy before you or your girlfriend/boyfriend confessing that she/his had premarital sex with another woman/man.',
    'You came to know your brother has an illegitimate child from a woman other than your mother.',
    'You have encountered a customer who is too demanding and complaints of pretty matters.',
    'You have a subordinate who cannot understand nor follow instructions.',
    'You encounter in a party an acquaintance who brags too much and tries to call attention to himself.',
    'A colleague, friends, sports, or co-workers openly argues with you and disagrees with your ideas during one of your meetings or discussions.'
  ];
  List<String> tolerances = [];

  @override
  void initState() {
    super.initState();
    tolerances = List.generate(toleranceTests.length, (index) => '');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getToleranceScore();
  }

  Future getToleranceScore() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final user = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      final userData = user.data() as Map<dynamic, dynamic>;
      final toleranceTestList =
          userData['toleranceTest']['entries'] as List<dynamic>;
      if (toleranceTestList.isNotEmpty)
        tolerances = List.from(toleranceTestList);
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Error getting tolerance score: $error')));
    }
  }

  Future saveToleranceTest() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      setState(() {
        _isLoading = true;
      });
      final user = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      final userData = user.data() as Map<dynamic, dynamic>;
      String rating = userData['toleranceTest']['rating'];
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'toleranceTest': {'entries': tolerances, 'rating': rating}
      });
      setState(() {
        _isLoading = false;
      });

      int toleranceScore = getToleranceLevel();
      String toleranceLevel = toleranceScore < 18
          ? 'High'
          : toleranceScore >= 18 && toleranceScore < 27
              ? 'Moderate'
              : 'Low';
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Your score is $toleranceScore. you have a $toleranceLevel tolerance.',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        Gap(40),
                        Text(
                          'The higher your score, the lower your level of tolerance.',
                          style: GoogleFonts.inter(fontSize: 20),
                        ),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('CLOSE',
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)))
                  ],
                ),
              )));
    } catch (error) {
      scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Error saving tolerance test: $error')));
      setState(() {
        _isLoading = false;
      });
    }
  }

  int getToleranceLevel() {
    int totalTolerance = 0;
    for (var tolerance in tolerances) {
      if (tolerance == 'HA') {
        totalTolerance += 3;
      } else if (tolerance == 'SA') {
        totalTolerance += 2;
      } else {
        totalTolerance++;
      }
    }
    return totalTolerance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: stackedLoadingContainer(
        context,
        _isLoading,
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                  image: AssetImage('lib/assets/images/icons/si_bg.jpg'),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(Icons.arrow_back)),
                    Text('Tolerance Test',
                        style: GoogleFonts.satisfy(
                            textStyle: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))),
                    IconButton(
                        onPressed: () {
                          selfAssessmentInstructionDialogue(
                              context,
                              'Assume that you are faced which the following situations. How are you inclined to react? (write your most probable reaction given your mood and temper, not one which you think should be an ideal reaction)',
                              'HA - Highly Affected which is means you are most inclined to be irritated, scandalized or to keep a grudge or to lose your temper\n\nSA - Slightly affected may be hurt or slightly irritated but not a point of being scandalized or keeping grudges or losing temper\n\nNA - Not Affected at all or you don’t give a damn.');
                        },
                        icon: Icon(Icons.help_outline_rounded))
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 0.2),
                      borderRadius: BorderRadius.circular(25),
                      color: Color.fromARGB(255, 219, 219, 219)),
                  child: allPadding8Pix(ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: toleranceTests.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onLongPress: () =>
                              displayToleranceSelectionDialog(index),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (tolerances[index].isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2),
                                            child: Text(tolerances[index],
                                                style: GoogleFonts.inter()),
                                          ),
                                        Divider(
                                            thickness: 2,
                                            color: Colors.black,
                                            height: 10)
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                    child: Text(toleranceTests[index],
                                        style: GoogleFonts.inter()))
                              ],
                            ),
                          ),
                        );
                      })),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 29, vertical: 19),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 110,
                        child: ElevatedButton(
                            onPressed: () {
                              if (tolerances.contains('')) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Please answer all tolerance tests.')));
                                return;
                              }
                              saveToleranceTest();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 175, 210, 244),
                                foregroundColor: Colors.black,
                                disabledBackgroundColor:
                                    Color.fromARGB(255, 153, 165, 177),
                                disabledForegroundColor:
                                    Color.fromARGB(255, 132, 126, 126),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40))),
                            child: Text('RESULT',
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)))),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  void displayToleranceSelectionDialog(int index) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(toleranceTests[index],
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(fontSize: 20))),
                    Column(
                      children: [
                        toleranceButton(context, label: 'HA (Highly Affected)',
                            onPress: () {
                          setState(() {
                            tolerances[index] = 'HA';
                          });
                          Navigator.of(context).pop();
                        }),
                        toleranceButton(context,
                            label: 'SA (Slightly Affected)', onPress: () {
                          setState(() {
                            tolerances[index] = 'SA';
                          });
                          Navigator.of(context).pop();
                        }),
                        toleranceButton(context, label: 'NA (Not Affected)',
                            onPress: () {
                          setState(() {
                            tolerances[index] = 'NA';
                          });
                          Navigator.of(context).pop();
                        }),
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}
