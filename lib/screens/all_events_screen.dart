import 'package:flutter/material.dart';

import '../widgets/app_bottom_navbar_widget.dart';

class AllEventsScreen extends StatefulWidget {
  const AllEventsScreen({super.key});

  @override
  State<AllEventsScreen> createState() => _AllEventsScreenState();
}

class _AllEventsScreenState extends State<AllEventsScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, ModalRoute.withName('/home'));
        return false;
      },
      child: Scaffold(
          bottomNavigationBar: bottomNavigationBar(context, 1),
          body: const Center(child: Text('ALL EVENTS'))),
    );
  }
}
