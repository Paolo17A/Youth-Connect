import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ywda/screens/register_second_page_screen.dart';
import 'package:ywda/widgets/bordered_text_container_widgert.dart';
import 'package:ywda/widgets/custom_buttons_widgets.dart';
import 'package:ywda/widgets/dropdown_widget.dart';

import '../widgets/custom_textfield_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  String _gender = 'MALE';
  String _civilStatus = 'SINGLE';
  DateTime? _selectedDate;
  int? age;
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _specialGenderController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _fullNameController.dispose();
    _cityController.dispose();
    _specialGenderController.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _selectedDate = picked;
        age = _calculateAge(_selectedDate!);
      });
    }
  }

  int _calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;

    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  void _submitInput() {
    if (_fullNameController.text.isEmpty ||
        _selectedDate == null ||
        _cityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill up all the fields.')));
      return;
    }

    if (age! < 15 || age! > 30) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('You must be 15-30 years old to join.')));
      return;
    }

    if (_gender == 'LET ME TYPE...' && _specialGenderController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please indicate your specific gender')));
      return;
    }

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => RegisterSecondPageScreen(
            fullName: _fullNameController.text,
            gender: _gender == 'LET ME TYPE...'
                ? _specialGenderController.text.trim()
                : _gender,
            civilStatus: _civilStatus,
            birthday: _selectedDate!,
            city: _cityController.text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.black,
          automaticallyImplyLeading: false,
          title: Center(
            child: Text('Registration',
                textAlign: TextAlign.center, style: GoogleFonts.poppins()),
          )),
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                children: [
                                  Text('Full Name'),
                                ],
                              ),
                            ),
                            customTextField('Full Name', _fullNameController,
                                TextInputType.name),
                          ],
                        ),
                      ),
                      dropdownWidget(_gender, (selected) {
                        setState(() {
                          if (selected != null) {
                            _gender = selected;
                          }
                        });
                      }, [
                        'WOMAN',
                        'MAN',
                        'NON-BINARY',
                        'TRANSGENDER',
                        'INTERSEX',
                        'LET ME TYPE...',
                        'PREFER NOT TO SAY'
                      ], 'Gender', false),
                      if (_gender == 'LET ME TYPE...')
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  children: [
                                    Text('Indicate Your Gender'),
                                  ],
                                ),
                              ),
                              customTextField('Gender',
                                  _specialGenderController, TextInputType.text),
                            ],
                          ),
                        ),
                      dropdownWidget(_civilStatus, (selected) {
                        setState(() {
                          if (selected != null) {
                            _civilStatus = selected;
                          }
                        });
                      }, [
                        'SINGLE',
                        'MARRIED',
                        'DIVORCED',
                        'SINGLE-PARENTS',
                        'WIDOWED',
                        'SEPARATE'
                      ], 'Civil Status', false),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                children: [
                                  Text('Date of Birth'),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.05),
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent),
                                  onPressed: () => _selectDate(context),
                                  child: Text(
                                      _selectedDate != null
                                          ? DateFormat('MMM dd, yyyy')
                                              .format(_selectedDate!)
                                          : '',
                                      style: GoogleFonts.poppins(
                                          color: Colors.black, fontSize: 15))),
                            ),
                          ],
                        ),
                      ),
                      borderedTextContainer(
                          'Age', age != null ? '$age years old' : ''),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                children: [
                                  Text('Current Residing City'),
                                ],
                              ),
                            ),
                            customTextField('City/Municipality',
                                _cityController, TextInputType.name),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      registerSubmitButton(() {
                        _submitInput();
                      })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
