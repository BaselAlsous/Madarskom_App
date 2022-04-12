import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool obscureText;
  final Function validator;
  final void Function(String) onChange;
  final bool readOnly;

  LoginField(
      {this.hintText,
      this.obscureText = false,
      @required this.labelText,
      this.controller,
      this.keyboardType,
      this.validator,
      this.onChange,
      this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        readOnly: readOnly,
        onChanged: onChange,
        validator: validator,
        keyboardType: keyboardType,
        controller: controller,
        obscureText: obscureText,
        style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16),
        textAlignVertical: TextAlignVertical(y: 0.6),
        decoration: InputDecoration(
          fillColor: Color(0xfff2f9fe),
          labelText: labelText,
          labelStyle: GoogleFonts.montserrat(
            color: Colors.grey,
            fontSize: 15,
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.montserrat(
            color: Colors.grey,
            fontSize: 15,
          ),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(25)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(25)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(25)),
        ));
  }
}
