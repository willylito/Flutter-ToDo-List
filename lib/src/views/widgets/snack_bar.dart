import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

SnackBar snackBar(message, isError) {
  return SnackBar(
    content: Text(
      message,
      style: GoogleFonts.poppins(fontSize: 12.0, color: Colors.white),
    ),
    backgroundColor: isError ? Colors.red.shade200 : Colors.blue.shade200,
  );
}
