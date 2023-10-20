import 'package:flutter/material.dart';

Color bottomNavButtonColor = const Color.fromARGB(255, 217, 217, 217);

void _processPress(int selectedIndex, int currentIndex, BuildContext context) {
  //  Do nothing if we are selecting the same bottom bar
  if (selectedIndex == currentIndex) {
    return;
  }
  switch (selectedIndex) {
    case 0:
      Navigator.pushNamed(context, '/assessment');
      break;
    case 1:
      Navigator.popUntil(context, ModalRoute.withName('/home'));
      break;
    case 2:
      Navigator.pushNamed(context, '/organization');
      break;
    case 3:
      Navigator.pushNamed(context, '/profile');
      break;
  }
}

Widget bottomNavigationBar(BuildContext context, int index) {
  return ClipRRect(
    borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    child: BottomNavigationBar(
      currentIndex: index,
      selectedFontSize: 0,
      items: [
        //  Self-Assessment
        BottomNavigationBarItem(
            icon: _buildIcon(Icons.paste, index == 0),
            backgroundColor: bottomNavButtonColor,
            label: 'Self-Assessment'),
        //  Programs & Events
        /*BottomNavigationBarItem(
            icon: _buildIcon(Icons.event, index == 1),
            backgroundColor: bottomNavButtonColor,
            label: 'Programs & Events'),*/
        //  Home
        BottomNavigationBarItem(
            icon: _buildIcon(Icons.home, index == 1),
            backgroundColor: bottomNavButtonColor,
            label: 'Home'),
        //  Organizations
        BottomNavigationBarItem(
            icon: _buildIcon(Icons.people, index == 2),
            backgroundColor: bottomNavButtonColor,
            label: 'Organizations'),
        //  Profile
        BottomNavigationBarItem(
            icon: _buildIcon(Icons.person, index == 3),
            backgroundColor: bottomNavButtonColor,
            label: 'Profie'),
      ],
      onTap: (int tappedIndex) {
        _processPress(tappedIndex, index, context);
      },
    ),
  );
}

Widget _buildIcon(IconData iconData, bool isSelected) {
  return isSelected
      ? Transform.scale(
          scale: 1.35,
          child: Icon(
            iconData,
            size: 32,
          ),
        )
      : Icon(
          iconData,
          size: 32,
        );
}
