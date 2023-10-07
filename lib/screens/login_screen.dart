import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/widgets/custom_textfield_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailAddressController.dispose();
    _passwordController.dispose();
  }

  void _loginUser() async {
    final scaffoldState = ScaffoldMessenger.of(context);
    final navigatorState = Navigator.of(context);
    FocusScope.of(context).unfocus();
    if (_emailAddressController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      scaffoldState.showSnackBar(
          const SnackBar(content: Text('Please fill up all the fields')));
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });
      //  Attempt log-in with username
      if (!_emailAddressController.text.contains('@') &&
          !_emailAddressController.text.contains('.com')) {
        final allUsers = await FirebaseFirestore.instance
            .collection('users')
            .where('username', isNull: false)
            .where('username', isEqualTo: _emailAddressController.text)
            .get();

        //  We found a user. We will log in using that email address.
        if (allUsers.docs.isNotEmpty) {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: allUsers.docs.first.data()['email'],
              password: _passwordController.text);
        }
        //  Username does not exist.
        else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  'No account with username \'${_emailAddressController.text}\' found.')));
          setState(() {
            _isLoading = false;
            _emailAddressController.clear();
            _passwordController.clear();
          });
          return;
        }
      }
      //  Sign in using the email and password
      else {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailAddressController.text,
            password: _passwordController.text);
      }

      //  Get the currentUserData
      final currentUserData = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      //  Check if the account has a userType parameter and create it if it doesn't.
      if (!currentUserData.data()!.containsKey('userType')) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'userType': 'CLIENT'});

        //  If the current user is an admin, display a mesaage.
      } else if (currentUserData.data()!['userType'] == 'ADMIN') {
        scaffoldState.showSnackBar(
            SnackBar(content: Text('Only clients may access this app')));
        await FirebaseAuth.instance.signOut();
        setState(() {
          _isLoading = false;
        });
        return;
      }

      if (currentUserData.data()!['accountInitialized'] == true) {
        navigatorState.pushReplacementNamed('/home');
      } else {
        navigatorState.pushReplacementNamed('/register');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
        _emailAddressController.clear();
        _passwordController.clear();
      });
      scaffoldState.showSnackBar(SnackBar(content: Text(error.toString())));
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
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Text('Welcome Back!',
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w600))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: customTextField(
                            'Username or Email',
                            _emailAddressController,
                            TextInputType.emailAddress),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: customTextField('Password', _passwordController,
                            TextInputType.visiblePassword),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(13),
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Text(
                                  'Forgot Password?',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(fontSize: 13)),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/forgot');
                                    },
                                    child: Text(
                                      'Click Here',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                              fontSize: 13,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontWeight: FontWeight.bold)),
                                    )),
                              )
                            ],
                          )),
                      const SizedBox(height: 25),
                      SizedBox(
                        height: 50,
                        width: 230,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 34, 52, 189),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: _loginUser,
                          child: Text('SIGN IN',
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 14))),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?',
                                style: GoogleFonts.poppins()),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/signup');
                                },
                                child: Text(
                                  'Sign Up',
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          decoration: TextDecoration.underline,
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
              ),
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
        ),
      ),
    );
  }
}
