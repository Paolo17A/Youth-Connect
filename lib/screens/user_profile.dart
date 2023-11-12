import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ywda/widgets/app_drawer_widget.dart';

import '../widgets/app_bottom_navbar_widget.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool _isLoading = true;
  String fullName = '';
  String username = '';
  String _profileImageURL = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getUserData();
  }

  void _getUserData() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    try {
      final currentUserData = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      fullName = currentUserData.data()!.containsKey('fullName')
          ? currentUserData.data()!['fullName']
          : '';

      username = currentUserData.data()!.containsKey('username')
          ? currentUserData.data()!['username']
          : '';

      if (currentUserData.data()!.containsKey('profileImageURL')) {
        _profileImageURL = currentUserData.data()!['profileImageURL'];
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'profileImageURL': _profileImageURL});
      }

      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      scaffoldMessenger.showSnackBar(
          SnackBar(content: Text('Error getting user profile: $error')));
    }
  }

  Widget _buildProfileImage() {
    if (_profileImageURL != '') {
      return CircleAvatar(
        radius: 50,
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(_profileImageURL),
      );
    } else {
      return const CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.person,
            size: 30,
            color: Color.fromARGB(255, 53, 113, 217),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.popUntil(context, ModalRoute.withName('/home'));
          return false;
        },
        child: Scaffold(
          appBar: AppBar(elevation: 0),
          bottomNavigationBar: bottomNavigationBar(context, 3),
          drawer: appDrawer(context),
          body: SafeArea(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.3),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: _buildProfileImage()),
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      //color: Colors.red,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Transform.scale(
                                              scale: 1.5,
                                              child: IconButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushNamed('/edit');
                                                },
                                                icon: Icon(
                                                    Icons.settings_outlined),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Text(
                                '$fullName',
                                overflow: TextOverflow.visible,
                                maxLines: 3,
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Text(
                                '($username)',
                                overflow: TextOverflow.visible,
                                maxLines: 3,
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        color: Colors.black, fontSize: 15)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('Gender Identity',
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25))),
                                    ],
                                  ),
                                  Image.asset(
                                      'lib/assets/images/icons/Gender Bread.png')
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
          ),
        ));
  }
}
