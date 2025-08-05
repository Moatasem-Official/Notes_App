import 'package:flutter/material.dart';

class CustomSplashScaleTransition extends StatelessWidget {
  const CustomSplashScaleTransition({super.key, required this.logoAnimation});

  final Animation<double> logoAnimation;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: logoAnimation,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
        ),
        child: Icon(Icons.edit_note_outlined, color: Colors.white, size: 60),
      ),
    );
  }
}
