import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ywda/widgets/custom_textfield_widget.dart';

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
  final _fullNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  void dispose() {
    super.dispose();
    _fullNameController.dispose();
  }

  void _getUserData() async {
    try {
      final currentUserData = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      _fullNameController.text = currentUserData.data()!.containsKey('fullName')
          ? currentUserData.data()!['fullName']
          : '';
      _profileImageURL = currentUserData.data()!.containsKey('profileImageURL')
          ? currentUserData.data()!['profileImageURL']
          : '';
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
    if (_fullNameController.text.isEmpty) {
      scaffoldMessenger
          .showSnackBar(SnackBar(content: Text('Please fill up all fields')));
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
        'fullName': _fullNameController.text,
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
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  child: Column(
                                children: [
                                  _buildProfileImage(),
                                  const SizedBox(height: 15),
                                  if (_imageFile != null)
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            _imageFile = null;
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 53, 113, 217)),
                                        child: const Text(
                                            'Remove Selected Picture')),
                                  if (_imageFile == null &&
                                      _profileImageURL != '')
                                    ElevatedButton(
                                        onPressed: _removeProfilePic,
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 53, 113, 217)),
                                        child: const Text(
                                            'Remove Current Picture')),
                                  ElevatedButton(
                                      onPressed: _pickImage,
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 53, 113, 217)),
                                      child:
                                          const Text('Upload Profile Picture')),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Text('Full Name',
                                          style: GoogleFonts.poppins()),
                                    ],
                                  ),
                                  customTextField('Full Name',
                                      _fullNameController, TextInputType.name),
                                ],
                              )),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3),
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

  Widget _buildProfileImage() {
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
}
