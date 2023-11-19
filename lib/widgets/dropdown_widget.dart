import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget dropdownWidget(
    String selectedOption,
    Function(String?) onDropdownValueChanged,
    List<String> dropdownItems,
    String label,
    bool searchable,
    {bool enabled = true}) {
  return Padding(
    padding: EdgeInsets.all(enabled ? 8 : 0),
    child: enabled
        ? DropdownSearch<String>(
            popupProps: PopupProps.menu(
                showSelectedItems: true,
                showSearchBox: searchable,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                      alignLabelWithHint: true,
                      hintText: 'Select your ${label.toLowerCase()}',
                      labelStyle: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                      ),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1)),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10)),
                )),
            items: dropdownItems,
            onChanged: enabled ? onDropdownValueChanged : null,
            selectedItem: label,
          )
        : Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                border: Border.all(color: Colors.black, width: 0.5),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
                padding: EdgeInsets.all(5),
                child: Row(children: [
                  Text(selectedOption,
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: 15))
                ]))),
  );
}
