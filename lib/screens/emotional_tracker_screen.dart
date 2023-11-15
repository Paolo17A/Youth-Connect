import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ywda/screens/monthly_emotional_tracker_report_screen.dart';
import 'package:ywda/widgets/custom_containers_widget.dart';
import 'package:ywda/widgets/custom_styling_widgets.dart';

class EmotionalTrackerScreen extends StatefulWidget {
  const EmotionalTrackerScreen({super.key});

  @override
  State<EmotionalTrackerScreen> createState() => _EmotionalTrackerScreenState();
}

class _EmotionalTrackerScreenState extends State<EmotionalTrackerScreen> {
  bool _isLoading = true;
  Map<String, dynamic> groupedEmotionEntries = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getEmotionalTrackerEntries();
  }

  void getEmotionalTrackerEntries() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final user = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      final userData = user.data() as Map<dynamic, dynamic>;
      final emotionTracker =
          userData['emotionTracker'] as Map<dynamic, dynamic>;

      //  Organize the emotional tracker entries
      for (var emotionEntry in emotionTracker.entries) {
        //print('eID ${emotionEntry.key}');
        Map<dynamic, dynamic> emotionData = emotionEntry.value;
        DateTime emotionDateTime =
            (emotionData['dateTime'] as Timestamp).toDate();
        String month = DateFormat('MMMM').format(emotionDateTime);
        int year = emotionDateTime.year;
        String formattedCategory = '$month ${year.toString()}';

        if (!groupedEmotionEntries.keys.contains(formattedCategory)) {
          groupedEmotionEntries[formattedCategory] = {
            'entries': [
              {
                'dateTime': emotionDateTime,
                'emotion': emotionData['emotion'],
                'description': emotionData['description']
              }
            ]
          };
        } else {
          List<dynamic> currentEntries =
              groupedEmotionEntries[formattedCategory]['entries'];
          Map<dynamic, dynamic> newEntry = {
            'dateTime': emotionDateTime,
            'emotion': emotionData['emotion'],
            'description': emotionData['description']
          };
          currentEntries.add(newEntry);
          groupedEmotionEntries[formattedCategory]['entries'] = currentEntries;
        }
        print(groupedEmotionEntries);
      }
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      scaffoldMessenger.showSnackBar(SnackBar(
          content: Text('Error getting emotional tracker entries: $error')));
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _getEmotionCloudPath(String emotion) {
    if (emotion == 'HAPPY') {
      return 'lib/assets/images/emotions/happiness.png';
    }
    if (emotion == 'ANGRY') {
      return 'lib/assets/images/emotions/anger.png';
    }
    if (emotion == 'BORED') {
      return 'lib/assets/images/emotions/bored.png';
    }
    if (emotion == 'IDK') {
      return 'lib/assets/images/emotions/Idk what to feel.png';
    }
    if (emotion == 'SAD') {
      return 'lib/assets/images/emotions/sadness.png';
    }
    if (emotion == 'STRESS') {
      return 'lib/assets/images/emotions/stress.png';
    }
    return 'lib/assets/images/emotions/null.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0,
          backgroundColor: Colors.transparent),
      body: switchedLoadingContainer(
          _isLoading,
          Stack(
            children: [
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
                    children: [],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset('lib/assets/images/icons/mh.png', scale: 1),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: allPadding8Pix(SingleChildScrollView(
                  child: Column(
                    children: [
                      Gap(80),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 0.2),
                            borderRadius: BorderRadius.circular(25),
                            color: Color.fromARGB(255, 219, 219, 219)
                                .withOpacity(0.5)),
                        child: groupedEmotionEntries.isNotEmpty
                            ? CarouselSlider.builder(
                                itemCount: groupedEmotionEntries.length,
                                itemBuilder: ((context, index, _) {
                                  List<dynamic> entries = groupedEmotionEntries[
                                      groupedEmotionEntries.keys
                                          .toList()[index]]['entries'];
                                  return Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(children: [
                                      Text(
                                          groupedEmotionEntries.keys
                                              .toList()[index],
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17)),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.6,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        child: Wrap(
                                            children: entries
                                                .map((entry) => Image.asset(
                                                    _getEmotionCloudPath(
                                                        entry['emotion']),
                                                    scale: 5))
                                                .toList()),
                                      ),
                                      ElevatedButton(
                                          onPressed: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      MonthlyEmotionalTrackerReportScreen(
                                                          monthYear: groupedEmotionEntries.keys
                                                              .toList()[index],
                                                          monthlyEntry:
                                                              entries))),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Color.fromARGB(
                                                  255, 175, 210, 244)),
                                          child: Text('Monthly Report',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)))
                                    ]),
                                  );
                                }),
                                options: CarouselOptions(
                                    height: MediaQuery.of(context).size.height *
                                        0.75,
                                    viewportFraction: 1,
                                    enableInfiniteScroll: false))
                            : Center(
                                child: Text(
                                    'NO EMOTIONAL TRACKER ENTRIES AVAILABLE',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30)),
                              ),
                      ),
                    ],
                  ),
                )),
              )
            ],
          )),
    );
  }
}
