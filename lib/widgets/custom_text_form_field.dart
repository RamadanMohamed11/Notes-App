import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.myController,
      required this.validatorMethod,
      required this.hintText,
      required this.onSavedMehod,
      required this.maxLines});
  final String? Function(String?)? validatorMethod;
  final TextEditingController myController;
  final Function(String?)? onSavedMehod;
  final String hintText;
  final int maxLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      onSaved: onSavedMehod,
      controller: myController,
      validator: validatorMethod,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.lightBlue)),
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
              fontSize: 28, color: Colors.lightBlue.withOpacity(0.8))),
    );
  }
}
