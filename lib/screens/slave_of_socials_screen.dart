import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/utils/instruction_dialogue_util.dart';
import 'package:ywda/widgets/custom_containers_widget.dart';
import 'package:ywda/widgets/custom_styling_widgets.dart';

import '../widgets/custom_buttons_widgets.dart';

class SlaveOfSocialsScreen extends StatefulWidget {
  const SlaveOfSocialsScreen({super.key});

  @override
  State<SlaveOfSocialsScreen> createState() => _SlaveOfSocialsScreenState();
}

class _SlaveOfSocialsScreenState extends State<SlaveOfSocialsScreen> {
  bool _isLoading = true;

  List<String> slaveOfSocialsTests = [
    'Do you get so upset and angry when rumors about you spread around?',
    'Do you feel very disappointed when your boss or spouse does not notice you or the good thing you have done?',
    'Do you apologize often even when not at fault?',
    'Do you tend to play “martyr” sacrificing yourself or your happiness in an effort to win other\'s love and approval?',
    'Do you feel threatened or deeply hurt or affected when someone disagrees with you?',
    'Do you fret or get irritated easily when confronted or given negative feedback?',
    'Are you hesitant to say “no” to the demands of others for fear of hurting them?',
    'Are you extremely bothered when you hear demeaning or discouraging statement like \“It won\'t work. There is no more hope for you\".',
    'Are you afraid to express disagreement when not convinced of what others have to say?',
    'Do you always dress and act in a way that is pleasing to others more than what is pleasing to you? ',
  ];
  List<int?> slaves = [];

  @override
  void initState() {
    super.initState();
    slaves = List.generate(slaveOfSocialsTests.length, (index) => null);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getSlaveOfSocialsScore();
  }

  Future getSlaveOfSocialsScore() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final user = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      final userData = user.data() as Map<dynamic, dynamic>;
      final slaveOfSocialsList =
          userData['slaveOfSocials']['entries'] as List<dynamic>;
      if (slaveOfSocialsList.isNotEmpty) slaves = List.from(slaveOfSocialsList);
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      scaffoldMessenger.showSnackBar(SnackBar(
          content: Text('Error getting slave of socials score: $error')));
    }
  }

  Future saveSlaveOfSSocialsTest() async {
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
      String rating = userData['slaveOfSocials']['rating'];

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'slaveOfSocials': {'entries': slaves, 'rating': rating}
      });
      setState(() {
        _isLoading = false;
      });

      int SoSScore = getSlaveOfSocialsLevel();

      String SoSLevel = 'Not at all affected';
      if (SoSScore >= 17 && SoSScore <= 20) {
        SoSLevel = 'Very Strong';
      } else if (SoSScore >= 13 && SoSScore <= 16) {
        SoSLevel = 'Strong';
      } else if (SoSScore >= 8 && SoSScore <= 12) {
        SoSLevel = 'Moderate';
      }
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
                          'Your score is $SoSScore. $SoSLevel.',
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
      scaffoldMessenger.showSnackBar(SnackBar(
          content: Text('Error saving slave of socials test: $error')));
      setState(() {
        _isLoading = false;
      });
    }
  }

  int getSlaveOfSocialsLevel() {
    int totalSoS = 0;
    for (var tolerance in slaves) {
      totalSoS += tolerance!;
    }
    return totalSoS;
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
                    Text('Are you a slave \n of Social Approval?',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.satisfy(
                            textStyle: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))),
                    IconButton(
                        onPressed: () {
                          selfAssessmentInstructionDialogue(
                              context,
                              'Long press a statement to answer the following as truthfully as possible.',
                              'Score 2 if the Statement is always true, \n\n1 if the statement is sometimes true, \n\n and 0 if the statement never true.');
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
                      itemCount: slaveOfSocialsTests.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onLongPress: () =>
                              displaySlaveOfSocialsSelectionDialog(index),
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
                                        if (slaves[index] != null)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2),
                                            child: Text(
                                                slaves[index].toString(),
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
                                    child: Text(slaveOfSocialsTests[index],
                                        style: GoogleFonts.inter()))
                              ],
                            ),
                          ),
                        );
                      })),
                ),
                submitSelfAssessmentEntry(
                    label: 'RESULT',
                    onPress: () {
                      if (slaves.contains(null)) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Please answer all slave of social approval tests.')));
                        return;
                      }
                      saveSlaveOfSSocialsTest();
                    })
              ],
            ),
          ),
        ),
      )),
    );
  }

  void displaySlaveOfSocialsSelectionDialog(int index) {
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
                    Text(slaveOfSocialsTests[index],
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(fontSize: 20))),
                    Column(
                      children: [
                        toleranceButton(context, label: '2 (Always True)',
                            onPress: () {
                          setState(() {
                            slaves[index] = 2;
                          });
                          Navigator.of(context).pop();
                        }),
                        toleranceButton(context, label: '1 (Sometimes True)',
                            onPress: () {
                          setState(() {
                            slaves[index] = 1;
                          });
                          Navigator.of(context).pop();
                        }),
                        toleranceButton(context, label: '0 (Never True)',
                            onPress: () {
                          setState(() {
                            slaves[index] = 0;
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
