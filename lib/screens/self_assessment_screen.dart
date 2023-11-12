import 'package:flutter/material.dart';
import 'package:ywda/widgets/app_drawer_widget.dart';
import '../widgets/app_bottom_navbar_widget.dart';
import '../widgets/custom_buttons_widgets.dart';

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
            automaticallyImplyLeading: true,
            actions: [
              Transform.scale(
                scale: 1.5,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/overallLeaderboard');
                    },
                    icon: Image.asset(
                        'lib/assets/images/icons/icons-ranking.png')),
              )
            ],
          ),
          drawer: appDrawer(context),
          bottomNavigationBar: bottomNavigationBar(context, 0),
          body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    selfAssessmentButton('lib/assets/images/icons/Bread.png',
                        'GENDER DEVELOPMENT', () {
                      Navigator.of(context).pushNamed('/genderDevelopment');
                    }),
                    selfAssessmentButton(
                        'lib/assets/images/icons/icons-brain.png',
                        'MENTAL HEALTH', () async {
                      Navigator.of(context).pushNamed('/mentalHealth');
                    }),
                    selfAssessmentButton(
                        'lib/assets/images/icons/Self Identification.png',
                        'SELF IDENTIFICATION', () {
                      Navigator.pushNamed(context, '/selfIdentification');
                    })
                  ],
                )),
          )),
    );
  }
}
