import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/widgets/custom_buttons_widgets.dart';
import 'package:ywda/widgets/custom_containers_widget.dart';
import 'package:ywda/widgets/custom_miscellaneous_widgets.dart';
import 'package:ywda/widgets/custom_styling_widgets.dart';
import 'package:ywda/widgets/youth_connect_textfield_widget.dart';

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
      final user = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      final userData = user.data() as Map<dynamic, dynamic>;

      //  Check if the account has a userType parameter and create it if it doesn't.
      if (!userData.containsKey('userType')) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'userType': 'CLIENT'});

        //  If the current user is an admin, display a mesaage.
      } else if (userData['userType'] == 'ADMIN') {
        scaffoldState.showSnackBar(
            SnackBar(content: Text('Only clients may access this app')));
        await FirebaseAuth.instance.signOut();
        setState(() {
          _isLoading = false;
        });
        return;
      }

      if (FirebaseAuth.instance.currentUser!.emailVerified == false) {
        //  The user's data in Firestore has a dateEmailVerificationSent paramter.
        if (userData.containsKey('dateEmailVerificationSent')) {
          DateTime dateEmailVerificationSent =
              (userData['dateEmailVerificationSent'] as Timestamp).toDate();
          if (DateTime.now().difference(dateEmailVerificationSent).inMinutes <
              50) {
            scaffoldState.showSnackBar(SnackBar(
                content: Text(
                    'Please check your email for the email verification link.')));
            setState(() {
              _isLoading = false;
            });
          } else {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .update({'dateEmailVerificationSent': DateTime.now()});
            await FirebaseAuth.instance.currentUser!.sendEmailVerification();
            scaffoldState.showSnackBar(SnackBar(
                content: Text(
                    'A new email verification link has been sent to your email.')));
            setState(() {
              _isLoading = false;
            });
          }
        }
        //  A dateEmailVerificationSent parameter does NOT yet exist.
        else {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({'dateEmailVerificationSent': DateTime.now()});
          await FirebaseAuth.instance.currentUser!.sendEmailVerification();
          scaffoldState.showSnackBar(SnackBar(
              content: Text(
                  'Please check your email for the email verification link.')));
          setState(() {
            _isLoading = false;
          });
        }
        return;
      }

      if (userData['accountInitialized'] == true) {
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
          child: stackedLoadingContainer(
            context,
            _isLoading,
            Stack(
              children: [
                loginDesign(),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _welcomeBack(),
                        allPadding8Pix(YouthConnectTextField(
                            text: 'Username or Email',
                            controller: _emailAddressController,
                            textInputType: TextInputType.emailAddress,
                            displayPrefixIcon: null)),
                        Gap(10),
                        allPadding8Pix(YouthConnectTextField(
                            text: 'Password',
                            controller: _passwordController,
                            textInputType: TextInputType.visiblePassword,
                            displayPrefixIcon: null)),
                        _forgotPassword(),
                        //Gap(25),
                        authenticationSubmitButton(
                            'SIGN IN', _loginUser, false),
                        Gap(30),
                        _dontHaveAccount(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _welcomeBack() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Text('Welcome Back!',
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.w600))),
    );
  }

  Widget _forgotPassword() {
    return Padding(
        padding: const EdgeInsets.all(13),
        child: Row(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/forgot');
                },
                child: Text(
                  'Forgot Password?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 13,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold)),
                ))
          ],
        ));
  }

  Widget _dontHaveAccount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Don\'t have an account?', style: GoogleFonts.poppins()),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/signup');
              },
              child: Text(
                'Sign Up',
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 53, 113, 217))),
              ))
        ],
      ),
    );
  }
}
