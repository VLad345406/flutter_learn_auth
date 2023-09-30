import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  final double width;
  final double left, right, top, bottom;
  final Function()? method;
  final String label;
  const Button({
    super.key,
    required this.width,
    required this.left,
    required this.right,
    required this.top,
    required this.bottom,
    required this.method,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 50,
      width: width,
      margin: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
      decoration: BoxDecoration(
        border: Border.all(width: 2),
      ),
      child: TextButton(
        onPressed: method,
        child: Text(
          label,
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
