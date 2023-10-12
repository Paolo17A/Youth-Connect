import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget registerSubmitButton(Function onPress) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 40,
          width: 120,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 34, 52, 189),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
            onPressed: () {
              onPress();
            },
            child: Text('NEXT',
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 14))),
          ),
        ),
      ],
    ),
  );
}
