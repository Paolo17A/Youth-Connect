import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/models/organization_model.dart';
import 'package:ywda/widgets/bordered_text_container_widgert.dart';
import 'package:ywda/widgets/custom_textfield_widget.dart';
import 'package:ywda/widgets/dropdown_widget.dart';

class RegisterSecondPageScreen extends StatefulWidget {
  final String fullName;
  final String gender;
  final String civilStatus;
  final DateTime birthday;
  final String city;
  const RegisterSecondPageScreen(
      {super.key,
      required this.fullName,
      required this.gender,
      required this.civilStatus,
      required this.birthday,
      required this.city});

  @override
  State<RegisterSecondPageScreen> createState() =>
      _RegisterSecondPageScreenState();
}

class _RegisterSecondPageScreenState extends State<RegisterSecondPageScreen> {
  bool _isLoading = false;
  String? _selectedCategory = '';
  final TextEditingController _schoolController = TextEditingController();
  String? _selectedInSchoolStatus = '';
  String? _selectedOutSchoolStatus = '';
  String? _selectedLaborForceStatus = '';
  String? _selectedOrg = '';
  String? _selectedNature;
  final TextEditingController _positionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _schoolController.dispose();
    _positionController.dispose();
  }

  void _submitRegistrationData() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    if (_selectedCategory == null ||
        _schoolController.text.isEmpty ||
        _selectedOrg == null ||
        _selectedNature == null ||
        _positionController.text.isEmpty) {
      scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text('Please fill up all fields')));
      return;
    }
    String chosenStatus = '';
    switch (_selectedCategory) {
      case 'IN SCHOOL':
        chosenStatus = _selectedInSchoolStatus!;
        break;
      case 'OUT OF SCHOOL':
        chosenStatus = _selectedOutSchoolStatus!;
        break;
      case 'LABOR FORCE':
        chosenStatus = _selectedLaborForceStatus!;
        break;
    }
    if (chosenStatus.isEmpty) {
      scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text('Please select your youth category.')));
    }
    try {
      setState(() {
        _isLoading = true;
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'accountInitialized': true,
        'fullName': widget.fullName,
        'gender': widget.gender,
        'civilStatus': widget.civilStatus,
        'birthday': widget.birthday,
        'category': _selectedCategory,
        'organization': _selectedOrg,
        'orgPosition': _positionController.text,
        'orgStatus': chosenStatus,
        'school': _schoolController.text,
        'skillsDeveloped': {},
        'surveyAnswers': {},
        'profileImageURL': ''
      });

      navigator.pushNamedAndRemoveUntil('/home', ModalRoute.withName('/'));
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
              child: Text('Registration', style: GoogleFonts.poppins()))),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                bottom: -40,
                right: -30,
                child: Transform.scale(
                  scaleY: -1,
                  child: Image.asset('lib/assets/images/icons/Design.png',
                      scale: 2.75),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      dropdownWidget(
                          _selectedCategory != null ? _selectedCategory! : '',
                          (selected) {
                        setState(() {
                          if (selected != null) {
                            _selectedCategory = selected;
                          }
                        });
                      }, ['IN SCHOOL', 'OUT OF SCHOOL', 'LABOR FORCE'],
                          'Youth Category', false),
                      if (_selectedCategory == 'IN SCHOOL')
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  Text('In School Status'),
                                ],
                              ),
                            ),
                            dropdownWidget(
                                _selectedInSchoolStatus != null
                                    ? _selectedInSchoolStatus!
                                    : '', (selected) {
                              setState(() {
                                if (selected != null) {
                                  _selectedInSchoolStatus = selected;
                                }
                              });
                            }, [
                              'HIGH SCHOOL',
                              'SENIOR HIGH SCHOOL',
                              'COLLEGE',
                              'POST GRADUATE',
                              'WORKING STUDENT'
                            ], 'Status', false),
                          ],
                        ),
                      if (_selectedCategory == 'OUT OF SCHOOL')
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  Text('Out of School Status'),
                                ],
                              ),
                            ),
                            dropdownWidget(
                                _selectedOutSchoolStatus != null
                                    ? _selectedOutSchoolStatus!
                                    : '', (selected) {
                              setState(() {
                                if (selected != null) {
                                  _selectedOutSchoolStatus = selected;
                                }
                              });
                            }, ['HIGH SCHOOL', 'SENIOR HIGH SCHOOL', 'COLLEGE'],
                                'Status', false),
                          ],
                        ),
                      if (_selectedCategory == 'LABOR FORCE')
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child:
                                  Row(children: [Text('Labor Force Status')]),
                            ),
                            dropdownWidget(
                                _selectedLaborForceStatus != null
                                    ? _selectedLaborForceStatus!
                                    : '', (selected) {
                              setState(() {
                                if (selected != null) {
                                  _selectedLaborForceStatus = selected;
                                }
                              });
                            }, [
                              'TECHNICIANS & ASSOCIATE PROFESSIONS SERVICE & SALES WORKERS',
                              'ELEMENTARY OCCUPATION',
                              'PLANT MACHINE OPERATORS & ASSEMBLERS'
                            ], 'Status', false),
                          ],
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: customTextField(
                            'School', _schoolController, TextInputType.name),
                      ),
                      dropdownWidget(_selectedOrg != null ? _selectedOrg! : '',
                          (selected) {
                        setState(() {
                          if (selected != null) {
                            _selectedOrg = selected;
                            _selectedNature =
                                getOrganizationByName(_selectedOrg!)
                                        .nature
                                        .isNotEmpty
                                    ? getOrganizationByName(_selectedOrg!)
                                        .nature
                                    : 'N/A';
                          }
                        });
                      }, getOrganizationNames(), 'Organization', true),
                      borderedTextContainer(
                        'Nature of Organization',
                        _selectedNature != null ? _selectedNature! : '',
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: customTextField('Position', _positionController,
                            TextInputType.name),
                      ),
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 40,
                              width: 120,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 34, 52, 189),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                                onPressed: _submitRegistrationData,
                                child: Text('SUBMIT',
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                            fontSize: 14))),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (_isLoading)
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
