import 'package:flutter/material.dart';

Widget loginDesign() {
  return Positioned(
    top: -15,
    right: -15,
    child: Image.asset('lib/assets/images/icons/Design.png', scale: 2.75),
  );
}

Widget registerDesign() {
  return Positioned(
    bottom: -40,
    right: -30,
    child: Transform.scale(
      scaleY: -1,
      child: Image.asset('lib/assets/images/icons/Design.png', scale: 2.75),
    ),
  );
}
