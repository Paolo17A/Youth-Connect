import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/widgets/custom_styling_widgets.dart';

class MonthlyEmotionalTrackerReportScreen extends StatefulWidget {
  final String monthYear;
  final List<dynamic> monthlyEntry;
  const MonthlyEmotionalTrackerReportScreen(
      {super.key, required this.monthYear, required this.monthlyEntry});

  @override
  State<MonthlyEmotionalTrackerReportScreen> createState() =>
      _MonthlyEmotionalTrackerReportScreenState();
}

class _MonthlyEmotionalTrackerReportScreenState
    extends State<MonthlyEmotionalTrackerReportScreen> {
  Map<String, int> emotionMap = {};

  @override
  void initState() {
    super.initState();
    for (var element in widget.monthlyEntry) {
      if (emotionMap.containsKey(element['emotion'])) {
        emotionMap[element['emotion']] = emotionMap[element['emotion']]! + 1;
      } else {
        emotionMap[element['emotion']] = 1;
      }
    }
    print(emotionMap);
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

  Color _getEmotionColor(String emotion) {
    if (emotion == 'HAPPY') {
      return Colors.yellow;
    }
    if (emotion == 'ANGRY') {
      return const Color.fromARGB(255, 134, 26, 18);
    }
    if (emotion == 'BORED') {
      return Colors.orange;
    }
    if (emotion == 'IDK') {
      return Colors.green;
    }
    if (emotion == 'SAD') {
      return Colors.blue;
    }
    if (emotion == 'STRESS') {
      return Colors.purple;
    }
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            automaticallyImplyLeading: true,
            elevation: 0,
            backgroundColor: Colors.transparent),
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                    image: AssetImage('lib/assets/images/icons/si_bg.jpg'),
                    fit: BoxFit.cover),
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
              child: SingleChildScrollView(
                  child: allPadding8Pix(Column(
                children: [
                  Gap(80),
                  Text(widget.monthYear,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold, fontSize: 25)),
                  Gap(40),
                  Column(
                      children: emotionMap.entries.map((emotion) {
                    Color thisColor = _getEmotionColor(emotion.key);
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(children: [
                        Image.asset(
                          _getEmotionCloudPath(emotion.key),
                          scale: 6,
                        ),
                        Container(
                          width: 20 * emotion.value.toDouble(),
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: thisColor),
                        ),
                        Gap(30),
                        Text(emotion.value.toString(),
                            selectionColor: thisColor,
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                                color: thisColor))
                      ]),
                    );
                  }).toList())
                ],
              ))),
            )
          ],
        ));
  }
}
