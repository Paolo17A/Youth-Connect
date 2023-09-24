import 'package:flutter/material.dart';

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
