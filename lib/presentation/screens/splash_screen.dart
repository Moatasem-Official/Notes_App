import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:note_app/presentation/screens/home_screen.dart'; // تأكد من استيراد شاشتك الرئيسية

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

    // --- إعداد الأنيميشن ---

    // 1. أنيميشن الشعار (ظهور مع ارتداد)
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _logoAnimation = CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut, // هذا يعطي التأثير الارتدادي الرائع
    );

    // 2. أنيميشن النص (صعود مع تلاشي)
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _textAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    // --- تشغيل تسلسل الأنيميشن ---
    _startAnimationSequence();

    // --- الانتقال للشاشة الرئيسية بعد فترة ---
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  void _startAnimationSequence() async {
    // نبدأ بأنيميشن الشعار
    await _logoController.forward();
    // بعد انتهاء الشعار، نبدأ بأنيميشن النص
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
      // لون الخلفية الليلي الساحر
      backgroundColor: const Color(0xFF1A1A2E),
      body: Stack(
        children: [
          // 1. الخلفية الحية بالجسيمات المتصاعدة
          const Positioned.fill(child: AnimatedParticles()),

          // 2. المحتوى (الشعار والنص)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // الشعار مع أنيميشن التكبير
                ScaleTransition(
                  scale: _logoAnimation,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.edit_note_outlined, // يمكنك تغيير الأيقونة
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // النص مع أنيميشن الصعود والتلاشي
                FadeTransition(
                  opacity: _textController,
                  child: SlideTransition(
                    position: _textAnimation,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- الجزء الخاص برسم الخلفية الحية ---

class AnimatedParticles extends StatefulWidget {
  const AnimatedParticles({super.key});

  @override
  State<AnimatedParticles> createState() => _AnimatedParticlesState();
}

class _AnimatedParticlesState extends State<AnimatedParticles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  final List<Particle> _particles = [];

  @override
  void initState() {
    super.initState();
    // ننشئ 50 جسيمًا بأحجام ومواقع عشوائية
    for (int i = 0; i < 50; i++) {
      _particles.add(Particle(_random));
    }

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(); // تكرار الأنيميشن بلا نهاية
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // تحديث مواقع الجسيمات مع كل إطار
        for (var particle in _particles) {
          particle.update();
        }
        return CustomPaint(painter: ParticlePainter(_particles));
      },
    );
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  ParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (var particle in particles) {
      paint.color = particle.color;
      canvas.drawCircle(
        Offset(particle.x * size.width, particle.y * size.height),
        particle.radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Particle {
  final Random random;
  double x, y, radius, speed;
  Color color;

  Particle(this.random)
    : x = random.nextDouble(),
      y = random.nextDouble(),
      radius = random.nextDouble() * 2 + 1,
      speed = random.nextDouble() * 0.0005 + 0.0002, // سرعة الصعود
      color = Colors.white.withOpacity(
        random.nextDouble() * 0.5 + 0.2,
      ); // شفافية عشوائية

  void update() {
    y -= speed; // الحركة للأعلى
    if (y < -0.1) {
      // إذا وصل للأعلى، يعود للأسفل من جديد
      y = 1.1;
      x = random.nextDouble();
    }
  }
}
