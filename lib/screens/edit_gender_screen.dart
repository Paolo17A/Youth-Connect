import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/widgets/custom_buttons_widgets.dart';
import 'package:ywda/widgets/custom_containers_widget.dart';

class EditGenderScreen extends StatefulWidget {
  const EditGenderScreen({super.key});

  @override
  State<EditGenderScreen> createState() => _EditGenderScreenState();
}

class _EditGenderScreenState extends State<EditGenderScreen> {
  bool _isLoading = true;
  bool _isInitialized = false;
  num genderIdentityF = 0;
  num genderIdentityM = 0;
  num genderExpressionF = 0;
  num genderExpressionM = 0;
  num biologicalSexF = 0;
  num biologicalSexM = 0;
  num sexAttractF = 0;
  num sexAttractM = 0;
  num romanceAttractF = 0;
  num romanceAttractM = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getGenderIdentity();
  }

  Future getGenderIdentity() async {
    if (_isInitialized) {
      return;
    }
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      final user = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      final userData = user.data()!;

      if (!userData.containsKey('genderDevelopment')) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          'genderDevelopment': {
            'genderIdentity': {'M': 0, 'F': 0},
            'genderExpression': {'M': 0, 'F': 0},
            'biologicalSex': {'M': 0, 'F': 0},
            'sexAttract': {'M': 0, 'F': 0},
            'romanceAttract': {'M': 0, 'F': 0},
          }
        });
      } else {
        final genderDevelopment =
            userData['genderDevelopment'] as Map<dynamic, dynamic>;
        genderIdentityF = genderDevelopment['genderIdentity']['F'];
        genderIdentityM = genderDevelopment['genderIdentity']['M'];
        genderExpressionF = genderDevelopment['genderExpression']['F'];
        genderExpressionM = genderDevelopment['genderExpression']['M'];
        biologicalSexF = genderDevelopment['biologicalSex']['F'];
        biologicalSexM = genderDevelopment['biologicalSex']['M'];
        sexAttractF = genderDevelopment['sexAttract']['F'];
        sexAttractM = genderDevelopment['sexAttract']['M'];
        romanceAttractF = genderDevelopment['romanceAttract']['F'];
        romanceAttractM = genderDevelopment['romanceAttract']['M'];
      }
      setState(() {
        _isLoading = false;
        _isInitialized = true;
      });
    } catch (error) {
      scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Error getting gender Identity: $error')));
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future saveGenderDevelopment() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    try {
      setState(() {
        _isLoading = true;
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'genderDevelopment': {
          'genderIdentity': {'M': genderIdentityM, 'F': genderIdentityF},
          'genderExpression': {'M': genderExpressionM, 'F': genderExpressionF},
          'biologicalSex': {'M': biologicalSexM, 'F': biologicalSexF},
          'sexAttract': {'M': sexAttractM, 'F': sexAttractF},
          'romanceAttract': {'M': romanceAttractM, 'F': romanceAttractF},
        }
      });

      scaffoldMessenger.showSnackBar(SnackBar(
        content: Text('Successfully updated gender development'),
        duration: Duration(seconds: 2),
      ));
      navigator.pop();
    } catch (error) {
      scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Error saving gender development: $error')));
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _genderIdentityCalculator() {
    if (genderIdentityM == 0 && genderIdentityF == 0) {
      return 'NON GENDER';
    }
    num difference = (genderIdentityM - genderIdentityF).abs();
    if (difference < 0.1) {
      return 'TWO-SPIRIT';
    }
    if (genderIdentityF > genderIdentityM && difference > 0.1) {
      return 'WOMAN';
    }
    if (genderIdentityM > genderIdentityF && difference > 0.1) {
      return 'MAN';
    }
    return 'GENDERQUEER';
  }

  String _genderExpressionCalculator() {
    if (genderExpressionM == 0 && genderExpressionF == 0) {
      return 'AGENDER';
    }
    num difference = (genderExpressionM - genderExpressionF).abs();
    if ((genderExpressionM == 0 && genderExpressionF <= 0.2) ||
        (genderExpressionF == 0 && genderExpressionM <= 0.2)) {
      return 'GENDER NEUTRAL';
    }
    if (genderExpressionF > genderExpressionM && difference > 0.1) {
      return 'FEMME';
    }
    if (genderExpressionM > genderExpressionF && difference > 0.1) {
      return 'BUTCH';
    }
    return 'ANDROGYNOUS';
  }

  String _biologicalSexCalculator() {
    if (biologicalSexM == 0 && biologicalSexF == 0) {
      return 'ASEX';
    }
    num difference = (biologicalSexM - biologicalSexF).abs();
    if ((biologicalSexM == 0 && biologicalSexF <= 0.2)) {
      return 'INTERSEX';
    }
    if (biologicalSexF > biologicalSexM && difference > 0.1) {
      return 'FEMALE';
    }
    if (biologicalSexM > biologicalSexF && difference > 0.1) {
      return 'MALE';
    }
    return 'MtF FEMALE';
  }

  String _sexAttractionCalculator() {
    if (sexAttractM == 0 && sexAttractF == 0) {
      return 'NOBODY';
    }
    if (sexAttractF == 1 && sexAttractM == 1) {
      return 'PANSEXUAL';
    }
    if ((sexAttractM == 0 && sexAttractF > 0) ||
        (sexAttractF == 0 && sexAttractM > 0)) {
      return 'STRAIGHT';
    }
    return 'BISEXUAL';
  }

  String _romanceAttractionCalculator() {
    if (romanceAttractM == 0 && romanceAttractF == 0) {
      return 'NOBODY';
    }
    if (romanceAttractF == 1 && romanceAttractM == 1) {
      return 'PANSEXUAL';
    }
    if ((romanceAttractM == 0 && romanceAttractF > 0) ||
        (romanceAttractF == 0 && romanceAttractM > 0)) {
      return 'STRAIGHT';
    }
    return 'BISEXUAL';
  }

  String resultExplanation(String result) {
    if (result == 'TWO-SPIRIT') {
      return 'A cultural term used by indigenous North Americans, describing someone who has both female and male spirit. You may see this referred to in the acronym LGBTQIA2SP. The 2SP stands for \'two spirit\'.';
    }
    if (result == 'GENDERQUEER') {
      return 'Someone who identifies outside the gender binary.';
    }
    if (result == 'BUTCH') {
      return 'A term used to describe someone who exhibits stereotypically masculine appearance or behaviour. In particular, a female identified person with a more masculine appearance and presentation.';
    }
    if (result == 'FEMME') {
      return 'A term used to describe a feminine identified gender expression.';
    }
    if (result == 'ANDROGYNOUS') {
      return 'Not identifying as being either male or female, but as a mixture of the two.';
    }
    if (result == 'GENDER NEUTRAL') {
      return 'Someone who doesn\'t identify with any gender identity.';
    }
    if (result == 'INTERSEX') {
      return 'Someone who biology doesn\'t completely match the typical medical definitions of male or female. Intersex people may or may not identify as trans. Doctors estimate around 1 in 100 babies are, to some degree, intersex.';
    }
    if (result == 'MtF FEMALE') {
      return 'A trans woman - someone who has transitioned from "male to female"';
    }
    if (result == 'ASEX') {
      return 'Someone who doesn’t experience sexual attraction.';
    }
    if (result == 'MALE') {
      return 'Someone sexually attracted to women';
    }
    if (result == 'FEMALE') {
      return 'Someone sexually attracted to men';
    }
    if (result == 'STRAIGHT') {
      return 'When someone is sexually attracted to people of a different gender. See heterosexual.';
    }
    if (result == 'BISEXUAL') {
      return 'Sexual attraction to people of two or more genders.';
    }
    if (result == 'PANSEXUAL') {
      return 'Someone who is sexually or romantically attracted to people of all gender identities.';
    }
    if (result == 'AGENDER') {
      return 'Someone who doesn’t identify with any gender.';
    }
    return 'N/A';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: stackedLoadingContainer(
                context,
                _isLoading,
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.05),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(children: [
                        _genderIdentityContainer(),
                        _genderExpressionContainer(),
                        _biologicalSexContainer(),
                        _sexualAttractionContainer(),
                        _romanticAttractionContainer(),
                        genderDevelopmentButton(
                            'SAVE', () => saveGenderDevelopment()),
                        const SizedBox(height: 15)
                      ]),
                    ),
                  ),
                ))));
  }

  Widget _genderIdentityContainer() {
    Color thisColor = Color.fromARGB(255, 21, 129, 143);
    return Stack(
      children: [
        _dashedContainer(
            _genderInteractables(
                label: 'Gender Identity',
                explanation:
                    'How you, in your head, define your gender, based on how much you align (or don\'t align) with what you understand to be the options for gender.',
                color: thisColor,
                femaleSlider: Slider(
                    value: genderIdentityF.toDouble(),
                    thumbColor: Colors.white,
                    activeColor: thisColor,
                    inactiveColor: thisColor.withOpacity(0.3),
                    onChanged: (newVal) {
                      setState(() {
                        genderIdentityF = newVal;
                      });
                    }),
                femaleLabel: 'Woman-ness',
                maleSlider: Slider(
                    value: genderIdentityM.toDouble(),
                    thumbColor: Colors.white,
                    activeColor: thisColor,
                    inactiveColor: thisColor.withOpacity(0.3),
                    onChanged: (newVal) {
                      setState(() {
                        genderIdentityM = newVal;
                      });
                    }),
                maleLabel: 'Man-ness',
                calculatedResult: _genderIdentityCalculator()),
            color: Colors.cyan),
        _stackedImageAsset('lib/assets/images/icons/icons-brain.png',
            scale: 5.5, top: 0, left: 2)
      ],
    );
  }

  Widget _genderExpressionContainer() {
    Color thisColor = Color.fromARGB(255, 206, 194, 89);
    return Stack(
      children: [
        _dashedContainer(
          _genderInteractables(
              label: 'Gender Expression',
              explanation:
                  'The ways you present gender, through your actions, dress, and demeanor, and how those presentations are interpreted based on gender norms.',
              color: Color.fromARGB(255, 206, 194, 89),
              femaleSlider: Slider(
                  value: genderExpressionF.toDouble(),
                  thumbColor: Colors.white,
                  activeColor: thisColor,
                  inactiveColor: thisColor.withOpacity(0.3),
                  onChanged: (newVal) {
                    setState(() {
                      genderExpressionF = newVal;
                    });
                  }),
              femaleLabel: 'Feminine',
              maleSlider: Slider(
                  value: genderExpressionM.toDouble(),
                  thumbColor: Colors.white,
                  activeColor: thisColor,
                  inactiveColor: thisColor.withOpacity(0.3),
                  onChanged: (newVal) {
                    setState(() {
                      genderExpressionM = newVal;
                    });
                  }),
              maleLabel: 'Masculine',
              calculatedResult: _genderExpressionCalculator()),
          color: Colors.yellow,
        ),
        _stackedImageAsset('lib/assets/images/icons/Bread.png',
            scale: 7, top: -2)
      ],
    );
  }

  Widget _biologicalSexContainer() {
    Color thisColor = Colors.deepPurple;
    return Stack(
      children: [
        _dashedContainer(
            _genderInteractables(
                label: 'Biological Sex',
                explanation:
                    'The physical sex characteristics you\'re born with  and develop, including genitalia, body shape, voice pitch, body hair, hormones, chromosomes, etc.',
                color: thisColor,
                femaleSlider: Slider(
                    value: biologicalSexF.toDouble(),
                    thumbColor: Colors.white,
                    activeColor: thisColor,
                    inactiveColor: thisColor.withOpacity(0.3),
                    onChanged: (newVal) {
                      setState(() {
                        biologicalSexF = newVal;
                      });
                    }),
                femaleLabel: 'Female-ness',
                maleSlider: Slider(
                    value: biologicalSexM.toDouble(),
                    thumbColor: Colors.white,
                    activeColor: thisColor,
                    inactiveColor: thisColor.withOpacity(0.3),
                    onChanged: (newVal) {
                      setState(() {
                        biologicalSexM = newVal;
                      });
                    }),
                maleLabel: 'Male-ness',
                calculatedResult: _biologicalSexCalculator()),
            color: Colors.purple),
        _stackedImageAsset('lib/assets/images/icons/icons-gender.png',
            scale: 9, top: 14, left: 8)
      ],
    );
  }

  Widget _sexualAttractionContainer() {
    Color thisColor = Color.fromARGB(255, 148, 32, 24);
    return Stack(
      children: [
        _dashedContainer(
            _genderInteractables(
                label: 'Sexually Attracted to',
                explanation: '',
                fontSize: 22,
                color: thisColor,
                femaleSlider: Slider(
                    value: sexAttractF.toDouble(),
                    thumbColor: Colors.white,
                    activeColor: thisColor,
                    inactiveColor: thisColor.withOpacity(0.3),
                    onChanged: (newVal) {
                      setState(() {
                        sexAttractF = newVal;
                      });
                    }),
                femaleLabel: 'Femininity',
                maleSlider: Slider(
                    value: sexAttractM.toDouble(),
                    thumbColor: Colors.white,
                    activeColor: thisColor,
                    inactiveColor: thisColor.withOpacity(0.3),
                    onChanged: (newVal) {
                      setState(() {
                        sexAttractM = newVal;
                      });
                    }),
                maleLabel: 'Masculinity',
                calculatedResult: _sexAttractionCalculator()),
            color: Colors.red),
        _stackedImageAsset('lib/assets/images/icons/icons-heart.png',
            scale: 1, top: 6, left: 3)
      ],
    );
  }

  Widget _romanticAttractionContainer() {
    Color thisColor = Color.fromARGB(255, 148, 32, 24);

    return Stack(
      children: [
        _dashedContainer(
            _genderInteractables(
                label: 'Romantically Attracted to',
                explanation: '',
                fontSize: 18,
                color: thisColor,
                femaleSlider: Slider(
                    value: romanceAttractF.toDouble(),
                    thumbColor: Colors.white,
                    activeColor: thisColor,
                    inactiveColor: thisColor.withOpacity(0.3),
                    onChanged: (newVal) {
                      setState(() {
                        romanceAttractF = newVal;
                      });
                    }),
                femaleLabel: 'Femininity',
                maleSlider: Slider(
                    value: romanceAttractM.toDouble(),
                    thumbColor: Colors.white,
                    activeColor: thisColor,
                    inactiveColor: thisColor.withOpacity(0.3),
                    onChanged: (newVal) {
                      setState(() {
                        romanceAttractM = newVal;
                      });
                    }),
                maleLabel: 'Masculinity',
                calculatedResult: _romanceAttractionCalculator()),
            color: Colors.red),
        _stackedImageAsset('lib/assets/images/icons/icons-heart.png',
            scale: 1, top: 6, left: 3)
      ],
    );
  }

  Widget _dashedContainer(Widget child, {required Color color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: DottedBorder(
        color: color,
        strokeWidth: 5,
        dashPattern: [10, 8],
        borderType: BorderType.RRect,
        radius: Radius.circular(20),
        padding: EdgeInsets.all(10),
        child: Container(height: 200, child: child),
      ),
    );
  }

  Widget _stackedImageAsset(String assetPath,
      {double scale = 5, double top = -5, double left = 10}) {
    return Positioned(
        top: top,
        left: left,
        child: Image.asset(
          assetPath,
          scale: scale,
        ));
  }

  Widget _genderInteractables(
      {required String label,
      String explanation = '',
      required Color color,
      required Slider femaleSlider,
      required String femaleLabel,
      required Slider maleSlider,
      required String maleLabel,
      required String calculatedResult,
      double fontSize = 23}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(label,
                  style: GoogleFonts.inika(
                      textStyle: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: color))),
            ),
            if (explanation.isNotEmpty)
              Transform.scale(
                  scale: 1.3,
                  child: IconButton(
                      onPressed: () =>
                          displayExplanationDialog(label, explanation),
                      icon: Icon(Icons.help_outline)))
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Transform.scale(
                  scale: 2, child: Icon(Icons.block, color: color)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    femaleSlider,
                    Text(femaleLabel,
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(fontSize: 12)))
                  ],
                ),
                Row(
                  children: [
                    maleSlider,
                    Text(maleLabel,
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(fontSize: 12)))
                  ],
                ),
              ],
            )
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  ElevatedButton(
                      onPressed: () => displayExplanationDialog(
                          calculatedResult,
                          resultExplanation(calculatedResult)),
                      style: ElevatedButton.styleFrom(backgroundColor: color),
                      child: Text(calculatedResult)),
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  void displayExplanationDialog(String name, String explanation) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(name,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold, fontSize: 25)),
                  //Gap(30),
                  Text(explanation,
                      //textAlign: TextAlign.justify,
                      style: GoogleFonts.inter(fontSize: 20))
                ],
              ),
            )));
  }
}
