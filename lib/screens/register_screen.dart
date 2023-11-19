import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ywda/screens/register_second_page_screen.dart';
import 'package:ywda/widgets/bordered_text_container_widgert.dart';
import 'package:ywda/widgets/custom_buttons_widgets.dart';
import 'package:ywda/widgets/dropdown_widget.dart';

import '../widgets/custom_miscellaneous_widgets.dart';
import '../widgets/custom_textfield_widget.dart';

class RegisterScreen extends StatefulWidget {
  final String username;
  final String email;
  final String password;
  const RegisterScreen(
      {super.key,
      required this.username,
      required this.email,
      required this.password});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String _gender = '';
  String _civilStatus = '';
  DateTime? _selectedDate;
  int? age;
  final TextEditingController _cityController = TextEditingController();
  String _residingCity = '';
  //final TextEditingController _specialGenderController =
  //TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    _cityController.dispose();
    //_specialGenderController.dispose();
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
    if (_firstNameController.text.isEmpty ||
        _middleNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _selectedDate == null ||
        _residingCity.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill up all the fields.')));
      return;
    }

    if (age! < 15 || age! > 30) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('You must be 15-30 years old to join.')));
      return;
    }

    /*if (_gender == 'LET ME TYPE...' && _specialGenderController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please indicate your specific gender')));
      return;
    }*/

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => RegisterSecondPageScreen(
            username: widget.username,
            email: widget.email,
            password: widget.password,
            firstName: _firstNameController.text,
            middleName: _middleNameController.text,
            lastName: _lastNameController.text,
            gender: _gender,
            civilStatus: _civilStatus,
            birthday: _selectedDate!,
            city: _residingCity)));
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
              registerDesign(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _firstName(),
                    _middleName(),
                    _lastName(),
                    _genderWidgets(),
                    _civilStatusDropdown(),
                    _birthdayAndAge(),
                    _municipality(),
                    Gap(30),
                    authenticationSubmitButton('NEXT', () {
                      _submitInput();
                    }, true)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _firstName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Row(children: [Text('First Name')])),
          customTextField(
              'First Name', _firstNameController, TextInputType.name),
        ],
      ),
    );
  }

  Widget _middleName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Row(children: [Text('Middle Name')])),
          customTextField(
              'Middle Name', _middleNameController, TextInputType.name),
        ],
      ),
    );
  }

  Widget _lastName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Row(children: [Text('Last Name')])),
          customTextField('last Name', _lastNameController, TextInputType.name),
        ],
      ),
    );
  }

  Widget _genderWidgets() {
    return Column(children: [
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
        'PREFER NOT TO SAY'
      ], 'Gender', false),
      if (_gender == 'NON-BINARY')
        borderedTextContainer('Gender Description',
            'Someone whose gender identity is outside of the gender binary of male and female.')
      else if (_gender == 'TRANSGENDER')
        borderedTextContainer('Gender Description',
            'Also known as trans. It is an umbrella term for people whose gender identity doesn\'t match the gender they were assigned at birth.',
            height: 65)
      else if (_gender == 'INTERSEX')
        borderedTextContainer('Gender Description',
            'Someone whose biology doesn\'t completely match the typical medical definitions of male or female.',
            height: 65)
      /*else if (_gender == 'LET ME TYPE...')
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
              customTextField(
                  'Gender', _specialGenderController, TextInputType.text),
            ],
          ),
        ),*/
    ]);
  }

  Widget _civilStatusDropdown() {
    return dropdownWidget(_civilStatus, (selected) {
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
    ], 'Civil Status', false);
  }

  Widget _birthdayAndAge() {
    return Column(children: [
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
                          ? DateFormat('MMM dd, yyyy').format(_selectedDate!)
                          : '',
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: 15))),
            ),
          ],
        ),
      ),
      borderedTextContainer('Age', age != null ? '$age years old' : ''),
    ]);
  }

  Widget _municipality() {
    return dropdownWidget(_residingCity, (selected) {
      setState(() {
        if (selected != null) {
          _residingCity = selected;
        }
      });
    }, [
      'Alaminos',
      'Bay',
      'Biñan',
      'Botocan',
      'Cabuyao',
      'Calamba',
      'Camp Vicente Lim',
      'Canlubang',
      'Cavinti',
      'College Los Baños',
      'Famy',
      'Kalayaan',
      'Liliw',
      'Los Baños',
      'Luisiana',
      'Lumban',
      'Mabitac',
      'Magdalena',
      'Majayjay',
      'Nagcarlan',
      'Paete',
      'Pagsanjan',
      'Pakil',
      'Pila',
      'Rizal',
      'San Pablo',
      'San Pedro',
      'Siniloan',
      'Sta. Cruz',
      'Sta. Maria',
      'Sta. Rosa',
      'Victoria'
    ], 'Residing City', false);
  }
}
