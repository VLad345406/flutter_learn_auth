import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Animate(
      child: Center(
        child: Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(bottom: 16),
          child: Image.asset('assets/images/logo.png'),
        ),
      )
          .animate()
          .shimmer(delay: 400.ms, duration: 1800.ms)
          .scaleXY(end: 1.1, duration: 600.ms)
          .then(delay: 600.ms)
          .scaleXY(end: 1 / 1.1),
    );
  }
}
