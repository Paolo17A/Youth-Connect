import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void displayInstructionDialogue(
    BuildContext ctx, String task, String instruction) {
  showDialog(
      context: ctx,
      builder: ((context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Task:',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(fontWeight: FontWeight.bold))),
                  Text(task,
                      textAlign: TextAlign.left,
                      softWrap: true,
                      style: GoogleFonts.poppins()),
                  const SizedBox(height: 30),
                  Text('Description:',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(fontWeight: FontWeight.bold))),
                  Text(instruction,
                      textAlign: TextAlign.justify,
                      softWrap: true,
                      style: GoogleFonts.poppins())
                ],
              )),
            ),
          ))));
}

void selfAssessmentInstructionDialogue(
    BuildContext ctx, String task, String instruction,
    {double? height}) {
  showDialog(
      context: ctx,
      builder: ((context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: height ?? MediaQuery.of(context).size.height * 0.75,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task,
                        textAlign: TextAlign.justify,
                        softWrap: true,
                        style: GoogleFonts.poppins()),
                    const SizedBox(height: 30),
                    Text(instruction,
                        textAlign: TextAlign.justify,
                        softWrap: true,
                        style: GoogleFonts.poppins())
                  ],
                )),
              ),
            ),
          ))));
}
