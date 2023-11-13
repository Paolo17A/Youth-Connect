import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ywda/widgets/custom_textfield_widget.dart';
import 'package:ywda/widgets/dropdown_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _isLoading = true;
  File? _imageFile;
  late ImagePicker imagePicker;
  late String _profileImageURL;
  final _firstNameController = TextEditingController();
  final _middlenameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _cityController = TextEditingController();
  DateTime? birthday;
  int age = 0;
  String _gender = '';
  List<String> fixedGenders = [
    'WOMAN',
    'MAN',
    'NON-BINARY',
    'TRANSGENDER',
    'INTERSEX',
    'PREFER NOT TO SAY'
  ];
  String _civilStatus = '';
  final _specialGenderController = TextEditingController();

  String? _selectedCategory = '';
  final TextEditingController _schoolController = TextEditingController();
  String? _selectedInSchoolStatus = '';
  String? _selectedOutSchoolStatus = '';
  String? _selectedLaborForceStatus = '';

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _middlenameController.dispose();
    _lastNameController.dispose();
    _cityController.dispose();
    _specialGenderController.dispose();
  }

  void _getUserData() async {
    try {
      final currentUserData = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      _firstNameController.text =
          currentUserData.data()!.containsKey('firstName')
              ? currentUserData.data()!['firstName']
              : '';

      _middlenameController.text =
          currentUserData.data()!.containsKey('middleName')
              ? currentUserData.data()!['middleName']
              : '';

      _cityController.text = currentUserData.data()!.containsKey('city')
          ? currentUserData.data()!['city']
          : '';

      _profileImageURL = currentUserData.data()!.containsKey('profileImageURL')
          ? currentUserData.data()!['profileImageURL']
          : '';

      birthday = (currentUserData.data()!['birthday'] as Timestamp).toDate();
      age = _calculateAge(birthday!);

      _gender = currentUserData.data()!['gender'];
      if (!fixedGenders.contains(_gender)) {
        _gender = 'LET ME TYPE...';
        _specialGenderController.text = currentUserData.data()!['gender'];
      }

      _civilStatus = currentUserData.data()!['civilStatus'];

      /*_selectedCategory = currentUserData.data()!['category'];
      switch (_selectedCategory) {
        case 'IN SCHOOL':
        _selectedInSchoolStatus = 
          break;
      }*/

      _schoolController.text = currentUserData.data()!['school'];
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error getting user data: $error')));
    }
  }

  void _updateUserProfile() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigatorState = Navigator.of(context);
    if (_firstNameController.text.isEmpty ||
        _middlenameController.text.isEmpty ||
        _lastNameController.text.isEmpty) {
      scaffoldMessenger
          .showSnackBar(SnackBar(content: Text('Please fill up all fields')));
      return;
    } else if (age < 15 || age > 30) {
      scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Your age must be between 15-30 years old.')));
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'firstName': _firstNameController.text,
        'middleName': _middlenameController.text,
        'lastName': _lastNameController.text,
        'city': _cityController.text,
        'birthday': birthday,
        'gender': _gender == 'LET ME TYPE...'
            ? _specialGenderController.text.trim()
            : _gender,
        'civilStatus': _civilStatus,
        'school': _schoolController.text.trim()
      });

      if (_imageFile != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profilePics')
            .child(FirebaseAuth.instance.currentUser!.uid);

        final uploadTask = storageRef.putFile(_imageFile!);
        final taskSnapshot = await uploadTask.whenComplete(() {});
        final downloadURL = await taskSnapshot.ref.getDownloadURL();

        // Update the user's data in Firestore with the image URL
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          'profileImageURL': downloadURL,
        });
      }
      setState(() {
        _isLoading = false;
      });
      scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Successfully edited profile!')));
      navigatorState.pop();
      navigatorState.pushReplacementNamed('/profile');
    } catch (error) {
      scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Error updating user profile: $error')));
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _removeProfilePic() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      setState(() {
        _isLoading = true;
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'profileImageURL': ''});

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profilePics')
          .child(FirebaseAuth.instance.currentUser!.uid);

      await storageRef.delete();

      setState(() {
        _imageFile = null;
        _profileImageURL = '';
        _isLoading = false;
      });
    } catch (error) {
      scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Error removing profile pic: $error')));
      setState(() {
        _imageFile = null;
        _profileImageURL = '';
        _isLoading = false;
      });
    }
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
        birthday = picked;
        age = _calculateAge(birthday!);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile', style: GoogleFonts.poppins())),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.85,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildProfileImageWidget(),
                              const SizedBox(height: 15),
                              if (_imageFile != null)
                                _removeSelectedPictureWidget(),
                              if (_imageFile == null && _profileImageURL != '')
                                _removeCurrentPictureWidget(),
                              _uploadProfilePictureWidget(),
                              const SizedBox(height: 20),
                              _fullNameWidget(),
                              _birthdayWidget(),
                              _cityWidget(),
                              _genderWidgets(),
                              _civilStatusWidgets(),
                              //_categoryWidgets(),
                              _schoolWidget(),
                              const SizedBox(height: 40),
                              ElevatedButton(
                                  onPressed: _updateUserProfile,
                                  child: const Text('SAVE CHANGES'))
                            ]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildProfileImageWidget() {
    if (_imageFile != null) {
      return CircleAvatar(radius: 70, backgroundImage: FileImage(_imageFile!));
    } else if (_profileImageURL != '') {
      return CircleAvatar(
        radius: 70,
        backgroundImage: NetworkImage(_profileImageURL),
      );
    } else {
      return const CircleAvatar(
          radius: 70,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.person,
            size: 100,
            color: Color.fromARGB(255, 53, 113, 217),
          ));
    }
  }

  Widget _removeSelectedPictureWidget() {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            _imageFile = null;
          });
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 53, 113, 217)),
        child: const Text('Remove Selected Picture'));
  }

  Widget _removeCurrentPictureWidget() {
    return ElevatedButton(
        onPressed: _removeProfilePic,
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 53, 113, 217)),
        child: const Text('Remove Current Picture'));
  }

  Widget _uploadProfilePictureWidget() {
    return ElevatedButton(
        onPressed: _pickImage,
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 53, 113, 217)),
        child: const Text('Upload Profile Picture'));
  }

  Widget _fullNameWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(children: [
            Text('First Name', style: GoogleFonts.poppins()),
          ]),
          customTextField(
              'First Name', _firstNameController, TextInputType.name),
        ],
      ),
    );
  }

  Widget _cityWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Row(children: [
          Text('Current Residing City', style: GoogleFonts.poppins()),
        ]),
        customTextField(
            'City/Municipality', _cityController, TextInputType.name),
      ]),
    );
  }

  Widget _birthdayWidget() {
    return Padding(
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
                child: Row(
                  children: [
                    Text(
                        birthday != null
                            ? DateFormat('MMM dd, yyyy').format(birthday!)
                            : '',
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: 15)),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget _genderWidgets() {
    return Padding(
        padding: EdgeInsets.all(8),
        child: Column(children: [
          Row(children: [
            Text('Gender', style: GoogleFonts.poppins()),
          ]),
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
          ], fixedGenders.contains(_gender) ? _gender : 'LET ME TYPE...',
              false),
          if (_gender == 'LET ME TYPE...')
            Column(
              children: [
                Row(
                  children: [
                    Text('Indicate Your Gender'),
                  ],
                ),
                customTextField(
                    'Gender', _specialGenderController, TextInputType.text),
              ],
            )
        ]));
  }

  Widget _civilStatusWidgets() {
    return Padding(
        padding: EdgeInsets.all(8),
        child: Column(children: [
          Row(children: [
            Text('Civil Status', style: GoogleFonts.poppins()),
          ]),
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
          ], _civilStatus, false),
        ]));
  }

  Widget _categoryWidgets() {
    return Padding(
        padding: EdgeInsets.all(8),
        child: Column(children: [
          Row(children: [
            Text('Youth Category', style: GoogleFonts.poppins()),
          ]),
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
                Row(
                  children: [
                    Text('In School Status'),
                  ],
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
                Row(
                  children: [
                    Text('Out of School Status'),
                  ],
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
                }, ['HIGH SCHOOL', 'SENIOR HIGH SCHOOL', 'COLLEGE'], 'Status',
                    false),
              ],
            ),
          if (_selectedCategory == 'LABOR FORCE')
            Column(
              children: [
                Row(children: [Text('Labor Force Status')]),
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
        ]));
  }

  Widget _schoolWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: customTextField('School', _schoolController, TextInputType.name),
    );
  }
}
