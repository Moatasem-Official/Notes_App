import 'dart:math';

import 'package:flutter/material.dart';

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
