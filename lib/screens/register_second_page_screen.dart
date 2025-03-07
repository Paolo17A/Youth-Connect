import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/widgets/bordered_text_container_widgert.dart';
import 'package:ywda/widgets/custom_buttons_widgets.dart';
import 'package:ywda/widgets/custom_containers_widget.dart';
import 'package:ywda/widgets/custom_styling_widgets.dart';
import 'package:ywda/widgets/custom_textfield_widget.dart';
import 'package:ywda/widgets/dropdown_widget.dart';

import '../widgets/custom_miscellaneous_widgets.dart';

class RegisterSecondPageScreen extends StatefulWidget {
  final String username;
  final String email;
  final String password;
  final String firstName;
  final String middleName;
  final String lastName;
  final String gender;
  final String civilStatus;
  final DateTime birthday;
  final String city;
  const RegisterSecondPageScreen(
      {super.key,
      required this.username,
      required this.email,
      required this.password,
      required this.firstName,
      required this.middleName,
      required this.lastName,
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
  String? _selectedOrgID;
  String? _selectedOrgName = '';
  String? _selectedNature;
  final TextEditingController _positionController = TextEditingController();

  Map<String, Map<String, dynamic>> orgsMap = {};
  List<String> allOrgNames = [];

  @override
  void dispose() {
    super.dispose();
    _schoolController.dispose();
    _positionController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getAllOrgs();
  }

  Future _getAllOrgs() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final orgs = await FirebaseFirestore.instance.collection('orgs').get();

      orgs.docs.forEach((DocumentSnapshot doc) {
        String docId = doc.id;
        String name = doc['name'];
        String nature = doc['nature'];

        // Add org name to the global list
        allOrgNames.add(name);

        // Store values in the map
        orgsMap[docId] = {
          'name': name,
          'nature': nature,
        };
        setState(() {
          _isLoading = false;
        });
      });
    } catch (error) {
      scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Error getting all orgs: $error')));
    }
  }

  String _getNatureForOrg(String orgName) {
    // Assuming all org names are unique
    String docId =
        orgsMap.keys.firstWhere((key) => orgsMap[key]!['name'] == orgName);
    return orgsMap[docId]!['nature'];
  }

  String _getIdForOrg(String orgName) {
    // Assuming all org names are unique
    String docId =
        orgsMap.keys.firstWhere((key) => orgsMap[key]!['name'] == orgName);
    return docId;
  }

  void _submitRegistrationData() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    if (_selectedCategory == null ||
        _schoolController.text.isEmpty ||
        _selectedOrgID == null ||
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
      return;
    }
    try {
      setState(() {
        _isLoading = true;
      });

      //  Proceed with registration of user.
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: widget.email,
        password: widget.password,
      );

      //  Update this user's data on Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'accountInitialized': true,
        'userType': 'CLIENT',
        'username': widget.username,
        'email': widget.email,
        'password': widget.password,
        'firstName': widget.firstName,
        'middleName': widget.middleName,
        'lastName': widget.lastName,
        'gender': widget.gender,
        'civilStatus': widget.civilStatus,
        'birthday': widget.birthday,
        'city': widget.city,
        'categoryGeneral': _selectedCategory,
        'categorySpecific': chosenStatus,
        'organization': _selectedOrgID,
        'orgPosition': _positionController.text,
        'school': _schoolController.text,
        'dateEmailVerificationSent': DateTime.now(),
        'selfIdentification': {},
        'skillsDeveloped': {},
        'surveyAnswers': {},
        'emotionTracker': {},
        'toleranceTest': {'entries': [], 'rating': ''},
        'slaveOfSocials': {'entries': [], 'rating': ''},
        'twentyStatements': {'entries': [], 'rating': ''},
        'hasTwentyStatementsBadge': false,
        'hasPersonalShieldBadge': false,
        'personalShield': {},
        'profileImageURL': '',
        'genderDevelopment': {
          'genderIdentity': {'M': 0, 'F': 0},
          'genderExpression': {'M': 0, 'F': 0},
          'biologicalSex': {'M': 0, 'F': 0},
          'sexAttract': {'M': 0, 'F': 0},
          'romanceAttract': {'M': 0, 'F': 0},
        }
      });

      //  Send email verification link to user's email.
      await userCredential.user!.sendEmailVerification();

      //  Update the org's participants in Firstore
      final org = await FirebaseFirestore.instance
          .collection('orgs')
          .doc(_selectedOrgID)
          .get();
      print(org.data());
      List<dynamic> orgMembers =
          (org.data() as Map<dynamic, dynamic>)['members'];
      orgMembers.add(FirebaseAuth.instance.currentUser!.uid);

      await FirebaseFirestore.instance
          .collection('orgs')
          .doc(_selectedOrgID)
          .update({'members': orgMembers});

      navigator.pushNamedAndRemoveUntil('/login', ModalRoute.withName('/'));
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Error registering user: $error')));
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
            child: stackedLoadingContainer(
          context,
          _isLoading,
          Stack(
            children: [
              registerDesign(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      _youthCategoryWidget(),
                      _selectedSchoolWidget(),
                      _selectedOrgWidget(),
                      _orgPositionWidget(),
                      const SizedBox(height: 50),
                      authenticationSubmitButton('FINISH', () {
                        _submitRegistrationData();
                      }, true)
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget _youthCategoryWidget() {
    return Column(
      children: [
        dropdownWidget(_selectedCategory != null ? _selectedCategory! : '',
            (selected) {
          setState(() {
            if (selected != null) {
              _selectedCategory = selected;
            }
          });
        }, ['IN SCHOOL', 'OUT OF SCHOOL', 'LABOR FORCE'], 'Youth Category',
            false),
        if (_selectedCategory == 'IN SCHOOL')
          Column(
            children: [
              horizontalPadding8Pix(Row(
                children: [
                  Text('In School Status'),
                ],
              )),
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
              horizontalPadding8Pix(Row(children: [
                Text('Out of School Status'),
              ])),
              dropdownWidget(
                  _selectedOutSchoolStatus != null
                      ? _selectedOutSchoolStatus!
                      : '', (selected) {
                setState(() {
                  if (selected != null) {
                    _selectedOutSchoolStatus = selected;
                  }
                });
              }, ['HIGH SCHOOL', 'SENIOR HIGH SCHOOL', 'COLLEGE'], 'Status',
                  false),
            ],
          ),
        if (_selectedCategory == 'LABOR FORCE')
          Column(
            children: [
              horizontalPadding8Pix(
                  Row(children: [Text('Labor Force Status')])),
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
      ],
    );
  }

  Widget _selectedSchoolWidget() {
    return allPadding8Pix(
        customTextField('School', _schoolController, TextInputType.name));
  }

  Widget _selectedOrgWidget() {
    return Column(children: [
      dropdownWidget(_selectedOrgName != null ? _selectedOrgName! : '',
          (selected) {
        setState(() {
          if (selected != null) {
            _selectedOrgName = selected;
            _selectedOrgID = _getIdForOrg(_selectedOrgName!);
            _selectedNature = _getNatureForOrg(_selectedOrgName!);
          }
        });
      }, allOrgNames, 'Organization', true),
      borderedTextContainer(
        'Nature of Organization',
        _selectedNature != null ? _selectedNature! : '',
      )
    ]);
  }

  Widget _orgPositionWidget() {
    return allPadding8Pix(
        customTextField('Position', _positionController, TextInputType.name));
  }
}
