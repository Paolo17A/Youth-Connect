import 'package:flutter/material.dart';
import 'package:ywda/utils/quit_dialogue_util.dart';
import 'package:ywda/widgets/app_bottom_navbar_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => displayQuitDialogue(context),
      child: Scaffold(
          bottomNavigationBar: bottomNavigationBar(context, 2),
          body: const Center(child: Text('HOME SCREEN'))),
    );
  }
}
