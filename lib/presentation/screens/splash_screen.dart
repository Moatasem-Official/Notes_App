import 'dart:async';
import 'package:flutter/material.dart';
import 'package:note_app/presentation/screens/home_screen.dart';
import 'package:note_app/presentation/widgets/Splash_Screen/custom_splash_animated_bg_color.dart';
import 'package:note_app/presentation/widgets/Splash_Screen/custom_splash_fade_transition.dart';
import 'package:note_app/presentation/widgets/Splash_Screen/custom_splash_scale_transition.dart'; // تأكد من استيراد شاشتك الرئيسية

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late Animation<double> _logoAnimation;
  late Animation<Offset> _textAnimation;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _logoAnimation = CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _textAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    _startAnimationSequence();

    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  void _startAnimationSequence() async {
    await _logoController.forward();
    await _textController.forward();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: Stack(
        children: [
          const Positioned.fill(child: AnimatedParticles()),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomSplashScaleTransition(logoAnimation: _logoAnimation),
                const SizedBox(height: 24),
                CustomSplashFadeTransition(
                  textController: _textController,
                  textAnimation: _textAnimation,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
