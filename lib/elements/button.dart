import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectButton extends StatelessWidget {
  final Function()? method;
  final String label;
  final Color textColor;
  const ProjectButton({
    super.key,
    required this.method,
    required this.label,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 50,
      width: screenWidth - 32,
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      decoration: BoxDecoration(
        border: Border.all(width: 2),
      ),
      child: TextButton(
        onPressed: method,
        child: Text(
          label,
          style: GoogleFonts.roboto(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
