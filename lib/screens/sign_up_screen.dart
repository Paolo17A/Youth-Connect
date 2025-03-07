import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/screens/register_screen.dart';
import 'package:ywda/utils/text_processor_util.dart';
import 'package:ywda/widgets/custom_miscellaneous_widgets.dart';
import 'package:ywda/widgets/youth_connect_textfield_widget.dart';

import '../widgets/custom_containers_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isLoading = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailAddressController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  Future<void> _registerUser() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    //  Guard conditionals
    if (_emailAddressController.text.isEmpty ||
        _usernameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text('Please fill up all fields.')));
      return;
    } else if (!isAlphanumeric(_usernameController.text)) {
      scaffoldMessenger.showSnackBar(const SnackBar(
          content:
              Text('The username most only consist of letters and numbers.')));
      return;
    } else if (!_emailAddressController.text.contains('@') ||
        !_emailAddressController.text.contains('.com')) {
      scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text('Please enter a valid email address.')));
      return;
    } else if (_passwordController.text != _confirmPasswordController.text) {
      scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text('Passwords do not match.')));
      return;
    } else if (_passwordController.text.length < 6) {
      scaffoldMessenger.showSnackBar(SnackBar(
          content: Text('Password must be awt least six characters long.')));
      return;
    }
    try {
      setState(() {
        _isLoading = true;
      });
      // Check if the desired username already exists in Firestore
      final usernameExists = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: _usernameController.text)
          .get();

      if (usernameExists.docs.isNotEmpty) {
        scaffoldMessenger.showSnackBar(
            const SnackBar(content: Text('Username is already taken.')));
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final emailExists = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: _emailAddressController.text)
          .get();

      if (emailExists.docs.isNotEmpty) {
        scaffoldMessenger.showSnackBar(
            const SnackBar(content: Text('Email is already taken.')));
        setState(() {
          _isLoading = false;
        });
        return;
      }
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RegisterScreen(
              username: _usernameController.text,
              email: _emailAddressController.text,
              password: _passwordController.text)));

      //  Proceed with registration of user.
      /*final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailAddressController.text,
        password: _passwordController.text,
      );

      // Store the username and UID in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'accountInitialized': false,
        'userType': 'CLIENT',
        'username': _usernameController.text,
        'email': _emailAddressController.text,
        'password': _passwordController.text,
        'fullName': '',
        'gender': '',
        'civilStatus': '',
        'birthday': DateTime(1970),
        'city': '',
        'categoryGeneral': '',
        'categorySpecific': '',
        'organization': '',
        'orgPosition': '',
        'school': '',
        'selfIdentification': {},
        'skillsDeveloped': {},
        'surveyAnswers': {},
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

      //  Redirect to the login screen when all of this is done.
      setState(() {
        _isLoading = false;
      });
      scaffoldMessenger.showSnackBar(
          const SnackBar(content: Text('Successfully created new account')));
      navigator.pushReplacementNamed('/login');*/
    } catch (e) {
      scaffoldMessenger.showSnackBar(SnackBar(content: Text(e.toString())));
      _usernameController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
      _emailAddressController.clear();
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: stackedLoadingContainer(
              context,
              _isLoading,
              Stack(
                children: [
                  loginDesign(),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Text('SIGN UP',
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w600))),
                        ),
                        Row(
                          children: [
                            Text('Account Details',
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800)))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: YouthConnectTextField(
                              text: 'Username',
                              controller: _usernameController,
                              textInputType: TextInputType.name,
                              displayPrefixIcon: null),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: YouthConnectTextField(
                              text: 'Email Address',
                              controller: _emailAddressController,
                              textInputType: TextInputType.emailAddress,
                              displayPrefixIcon: null),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: YouthConnectTextField(
                              text: 'Password',
                              controller: _passwordController,
                              textInputType: TextInputType.visiblePassword,
                              displayPrefixIcon: null),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: YouthConnectTextField(
                              text: 'Confirm Password',
                              controller: _confirmPasswordController,
                              textInputType: TextInputType.visiblePassword,
                              displayPrefixIcon: null),
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
                                      backgroundColor: const Color.fromARGB(
                                          255, 34, 52, 189),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  onPressed: _registerUser,
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
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already have an account?',
                                  style: GoogleFonts.poppins()),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacementNamed('/login');
                                  },
                                  child: Text(
                                    'Log In',
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 53, 113, 217))),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
