import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget borderedTextContainer(String label, String textInput,
    {double height = 50}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              Text(label),
            ],
          ),
        ),
        Container(
            height: height,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black)),
            child: Center(
              child: Text(textInput,
                  textAlign: TextAlign.center, style: GoogleFonts.poppins()),
            )),
      ],
    ),
  );
}
