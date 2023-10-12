import 'package:flutter/material.dart';

Padding horizontalPadding5pix(Widget child) {
  return Padding(padding: EdgeInsets.symmetric(horizontal: 5), child: child);
}

Padding horizontalPadding8Pix(Widget child) {
  return Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: child);
}

Padding allPadding4pix(Widget child) {
  return Padding(padding: EdgeInsets.all(4), child: child);
}

Padding allPadding8Pix(Widget child) {
  return Padding(padding: EdgeInsets.all(8), child: child);
}

BoxDecoration decorationWithShadow() {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(0, 5))
      ]);
}

BoxDecoration projectDecoration() {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Color.fromARGB(255, 156, 183, 209),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(0, 3))
      ]);
}

TextStyle titleTextStyle() {
  return TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
}

TextStyle contentTextStyle() {
  return TextStyle(overflow: TextOverflow.ellipsis, fontSize: 15);
}

TextStyle noEntryTextStyle() {
  return TextStyle(
      color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold);
}
