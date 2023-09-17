import 'package:flutter/material.dart';

import '../widgets/app_bottom_navbar_widget.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, ModalRoute.withName('/home'));
        return false;
      },
      child: Scaffold(
          bottomNavigationBar: bottomNavigationBar(context, 4),
          body: const Center(child: Text('User Profile Screen'))),
    );
  }
}
