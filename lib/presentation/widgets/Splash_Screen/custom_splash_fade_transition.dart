import 'package:flutter/material.dart';

class CustomSplashFadeTransition extends StatelessWidget {
  const CustomSplashFadeTransition({
    super.key,
    required this.textController,
    required this.textAnimation,
  });

  final Animation<double> textController;
  final Animation<Offset> textAnimation;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: textController,
      child: SlideTransition(
        position: textAnimation,
        child: const Text(
          'Nota',
          style: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
