import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool showVisibleButton;
  final String label;

  const ProjectTextField({
    super.key,
    required this.controller,
    required this.showVisibleButton,
    required this.label
  });

  @override
  State<ProjectTextField> createState() => _ProjectTextFieldState();
}

class _ProjectTextFieldState extends State<ProjectTextField> {
  bool _isObscure = true;

  void showPassword() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.showVisibleButton ? _isObscure : false,
        enableSuggestions: false,
        autocorrect: false,
        style: GoogleFonts.roboto(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
        ),

        decoration: InputDecoration(
          suffixIcon: widget.showVisibleButton ? IconButton(
            icon: Icon(
              _isObscure ? Icons.visibility : Icons.visibility_off,
              color: Colors.black,
            ),
            onPressed: showPassword,
          ) : null,
          labelText: widget.label,
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.zero),
            borderSide: BorderSide(
              width: 2,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.zero),
            borderSide: BorderSide(
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
