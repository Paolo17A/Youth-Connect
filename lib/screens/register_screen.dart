import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ywda/screens/register_second_page_screen.dart';
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
  final TextEditingController _cityController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _fullNameController.dispose();
    _cityController.dispose();
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
      });
    }
  }

  void _submitInput() {
    if (_fullNameController.text.isEmpty ||
        _selectedDate == null ||
        _cityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill up all the fields')));
      return;
    }

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => RegisterSecondPageScreen(
            fullName: _fullNameController.text,
            gender: _gender,
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: dropdownWidget(_gender, (selected) {
                          setState(() {
                            if (selected != null) {
                              _gender = selected;
                            }
                          });
                        }, ['MALE', 'FEMALE'], 'Gender', false),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: dropdownWidget(_civilStatus, (selected) {
                          setState(() {
                            if (selected != null) {
                              _civilStatus = selected;
                            }
                          });
                        }, ['SINGLE', 'MARRIED', 'ANNULLED', 'WIDOWED'],
                            'Civil Status', false),
                      ),
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
                                          ? DateFormat('MMM dd yyyy')
                                              .format(_selectedDate!)
                                          : '',
                                      style: GoogleFonts.poppins(
                                          color: Colors.black, fontSize: 15))),
                            ),
                          ],
                        ),
                      ),
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
                                onPressed: _submitInput,
                                child: Text('NEXT',
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
            ],
          ),
        ),
      ),
    );
  }
}
