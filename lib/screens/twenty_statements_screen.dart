import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/widgets/custom_containers_widget.dart';
import 'package:ywda/widgets/custom_textfield_widget.dart';

import '../utils/instruction_dialogue_util.dart';
import '../widgets/custom_styling_widgets.dart';

class TwentyStatementsScreen extends StatefulWidget {
  const TwentyStatementsScreen({super.key});

  @override
  State<TwentyStatementsScreen> createState() => _TwentyStatementsScreenState();
}

class _TwentyStatementsScreenState extends State<TwentyStatementsScreen> {
  bool _isLoading = false;
  List<String> statements = List.generate(20, (index) => '');
  final statementController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getTwentyStatements();
  }

  @override
  void dispose() {
    super.dispose();
    statementController.dispose();
  }

  Future getTwentyStatements() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final user = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      final userData = user.data() as Map<dynamic, dynamic>;
      final toleranceTestList =
          userData['twentyStatements']['entries'] as List<dynamic>;
      if (toleranceTestList.isNotEmpty)
        statements = List.from(toleranceTestList);
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Error getting twenty Statements: $error')));
    }
  }

  void saveTwentyStatements() async {
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
      String rating = userData['twentyStatements']['rating'];
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'twentyStatements': {'entries': statements, 'rating': rating}
      });
      getTwentyStatements();
    } catch (error) {
      scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Error saving twenty statements: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                          image:
                              AssetImage('lib/assets/images/icons/si_bg.jpg'),
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
                            Text('Twenty Statements',
                                style: GoogleFonts.satisfy(
                                    textStyle: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black))),
                            IconButton(
                                onPressed: () {
                                  selfAssessmentInstructionDialogue(
                                      context,
                                      'Complete the Twenty-Statement Survey below.',
                                      'Write down the first statements that came to your mind upon hearing the phrase "I am."');
                                },
                                icon: Icon(Icons.help_outline_rounded))
                          ],
                        ),
                        _twentyStatementsContainer(),
                        Gap(30)
                      ],
                    ),
                  ),
                ))),
      ),
    );
  }

  Widget _twentyStatementsContainer() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.2),
          borderRadius: BorderRadius.circular(25),
          color: Color.fromARGB(255, 219, 219, 219)),
      child: allPadding8Pix(ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 20,
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: () => displayAddStatementDialog(index),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Wrap(
                  children: [
                    Text('I am ', style: GoogleFonts.inter()),
                    if (statements[index].isNotEmpty)
                      Text(statements[index],
                          style:
                              TextStyle(decoration: TextDecoration.underline))
                    else
                      Text('__________________________________________')
                  ],
                ),
              ),
            );
          })),
    );
  }

  void displayAddStatementDialog(int index) {
    statementController.text = statements[index];
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  content: Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Column(
                      children: [
                        Text('Add a Statement',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(fontSize: 20))),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: customTextField('Statement',
                              statementController, TextInputType.multiline),
                        ),
                        Gap(30),
                        ElevatedButton(
                            onPressed: () {
                              statements[index] = statementController.text;
                              Navigator.of(context).pop();
                              saveTwentyStatements();
                            },
                            child: Text('Save Statement',
                                style: GoogleFonts.inter(
                                    fontSize: 25, fontWeight: FontWeight.bold)))
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
