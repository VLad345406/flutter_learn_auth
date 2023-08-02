import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context){

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Learn auth'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: screenWidth - 40,
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              border: Border.all(width: 2),
            ),
            child: TextButton(
              onPressed: (){
                Navigator.pushNamed(context, '/login');
              },
              child: Text(
                'Log in',
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            width: screenWidth - 40,
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              border: Border.all(width: 2),
            ),
            child: TextButton(
              onPressed: (){
                Navigator.pushNamed(context, '/registration');
              },
              child: Text(
                'Registration',
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}