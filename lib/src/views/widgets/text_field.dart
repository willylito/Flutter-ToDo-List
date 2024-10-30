import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final String error;
  final bool isDescription;
  final TextInputType keyboardType;

  const TextFieldWidget({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.error,
    required this.isDescription,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 18.0)),
        const SizedBox(height: 10.0),
        Container(
          height: isDescription ? 120.0 : 50.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              style: GoogleFonts.poppins(fontSize: 14.0),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.black54),
              ),
            ),
          ),
        ),
        const SizedBox(height: 2.0),
        Offstage(
          offstage: error.isEmpty,
          child: Text(
            error,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
