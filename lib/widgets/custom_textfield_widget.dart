import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextField customTextField(String text, TextEditingController controller,
    TextInputType textInputType) {
  return TextField(
      controller: controller,
      obscureText: textInputType == TextInputType.visiblePassword,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
          alignLabelWithHint: true,
          labelText: text,
          labelStyle: TextStyle(
            color: Colors.black.withOpacity(0.4),
          ),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          //fillColor: Colors.white.withOpacity(0.4),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black, width: 1)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
      keyboardType: textInputType,
      maxLines: textInputType == TextInputType.multiline ? 9 : 1);
}

TextField selfIdentificationTextField(
    String text,
    TextEditingController controller,
    TextInputType textInputType,
    bool readOnly) {
  return TextField(
      controller: controller,
      obscureText: textInputType == TextInputType.visiblePassword,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      readOnly: readOnly,
      decoration: InputDecoration(
          alignLabelWithHint: true,
          labelText: text,
          labelStyle: GoogleFonts.poppins(
              textStyle: TextStyle(
            color: Colors.black.withOpacity(0.3),
          )),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: const Color.fromARGB(255, 218, 218, 218),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: Colors.black.withOpacity(0.3), width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: Colors.black.withOpacity(0.3), width: 1)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
      keyboardType: textInputType,
      maxLines: textInputType == TextInputType.multiline ? 9 : 1);
}
