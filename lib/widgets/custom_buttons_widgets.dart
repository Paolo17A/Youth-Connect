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

Widget genderDevelopmentButton(String label, Function onPress) {
  return ElevatedButton(
      onPressed: () {
        onPress();
      },
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          label,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),
        ),
      ));
}

Widget selfAssessmentButton(String imagePath, String label, Function onPress,
    {double size = 20}) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: SizedBox(
        width: double.infinity,
        height: 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
          onPressed: () {
            onPress();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (imagePath.isNotEmpty)
                SizedBox(
                  width: 75,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(imagePath),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(label,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: size,
                            color: Colors.black,
                            fontWeight: FontWeight.bold))),
              )
            ],
          ),
        )),
  );
}
