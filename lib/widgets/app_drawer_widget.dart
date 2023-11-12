import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Drawer appDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: const Color.fromARGB(255, 227, 236, 244),
    child: Column(
      children: [
        Flexible(
          flex: 1,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Color.fromARGB(255, 21, 57, 119),
                  ),
                  title: Text('Home', style: _textStyle()),
                  onTap: () => Navigator.pushReplacementNamed(context, '/home'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListTile(
                  leading: const Icon(Icons.help,
                      color: Color.fromARGB(255, 21, 57, 119)),
                  title: Text(
                    'FAQs',
                    style: _textStyle(),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/faqs');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListTile(
                  leading: const Icon(Icons.info,
                      color: Color.fromARGB(255, 21, 57, 119)),
                  title: Text('About Us', style: _textStyle()),
                  onTap: () {
                    Navigator.pop(context);
                    //Navigator.pushNamed(context, '/about');
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 21, 57, 119),
                borderRadius: BorderRadius.circular(50)),
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: Text('Log Out',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white)),
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.popUntil(context, (route) => route.isFirst);
                });
              },
            ),
          ),
        ),
      ],
    ),
  );
}

TextStyle _textStyle() {
  return const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: Color.fromARGB(255, 21, 57, 119));
}
