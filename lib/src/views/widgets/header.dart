import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderWidget extends StatelessWidget {
  final String title;

  const HeaderWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new_rounded)),
        const SizedBox(width: 20.0),
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 24.0),
        )
      ],
    );
  }
}
