import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/custom_textfield_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool _isLoading = false;
  TextEditingController _emailAddressController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailAddressController.dispose();
  }

  void _sendResetEmail() async {
    if (_emailAddressController.text.isEmpty ||
        !_emailAddressController.text.contains('@') ||
        !_emailAddressController.text.contains('.com')) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please provide a valid email address.')));
      return;
    }
    try {
      setState(() {
        _isLoading = true;
      });
      final allUsers = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: _emailAddressController.text.trim())
          .get();

      if (allUsers.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'No user with email address \'${_emailAddressController.text.trim()}\' found.')));
        setState(() {
          _isLoading = false;
          _emailAddressController.clear();
        });
        return;
      }
      FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailAddressController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sucessfully sent reset password email.')));
      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sending reset email: $error')));
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
            child: Stack(
              children: [
                Positioned(
                  top: -15,
                  right: -15,
                  child: Image.asset('lib/assets/images/icons/Design.png',
                      scale: 2.75),
                ),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.9,
                      child: Column(
                        children: [
                          const SizedBox(height: 100),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: Text('Reset your Password',
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 32,
                                        fontWeight: FontWeight.w600))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: customTextField(
                                'Email Address',
                                _emailAddressController,
                                TextInputType.emailAddress),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 50,
                            width: 230,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 34, 52, 189),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: _sendResetEmail,
                              child: Text('SEND RESET EMAIL',
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          fontSize: 12))),
                            ),
                          ),
                        ],
                      ),
                    )),
                if (_isLoading)
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          )),
    );
  }
}
