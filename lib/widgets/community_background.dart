import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CommunityBackground extends StatefulWidget {
  const CommunityBackground({super.key});

  @override
  State<CommunityBackground> createState() => _CommunityBackgroundState();
}

class _CommunityBackgroundState extends State<CommunityBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/we are better together.jpg', fit: BoxFit.cover),

          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: _CommunityPainter(animationValue: _controller.value),
                size: Size.infinite,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CommunityPainter extends CustomPainter {
  final double animationValue;

  _CommunityPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    // Large soft background glow
    final glowPaint = Paint()
      ..shader =
          RadialGradient(
            colors: [
              AppColors.primary.withValues(alpha: 0.08),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.85, size.height * 0.08),
              radius: size.width * 0.55,
            ),
          );

    canvas.drawCircle(
      Offset(size.width * 0.85, size.height * 0.08),
      size.width * 0.55,
      glowPaint,
    );

    // Second soft glow
    final secondGlowPaint = Paint()
      ..shader =
          RadialGradient(
            colors: [
              AppColors.teal.withValues(alpha: 0.07),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.08, size.height * 0.75),
              radius: size.width * 0.45,
            ),
          );

    canvas.drawCircle(
      Offset(size.width * 0.08, size.height * 0.75),
      size.width * 0.45,
      secondGlowPaint,
    );

    // Community network
    _drawNetwork(canvas, size);
  }

  void _drawNetwork(Canvas canvas, Size size) {
    final nodes = [
      Offset(size.width * 0.10, size.height * 0.16),
      Offset(size.width * 0.88, size.height * 0.22),
      Offset(size.width * 0.94, size.height * 0.58),
      Offset(size.width * 0.12, size.height * 0.66),
      Offset(size.width * 0.82, size.height * 0.84),
      Offset(size.width * 0.30, size.height * 0.92),
    ];

    final linePaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.07)
      ..strokeWidth = 1.5;

    // Connection lines
    for (int i = 0; i < nodes.length; i++) {
      for (int j = i + 1; j < nodes.length; j++) {
        final distance = (nodes[i] - nodes[j]).distance;

        if (distance < size.width * 0.55) {
          canvas.drawLine(nodes[i], nodes[j], linePaint);
        }
      }
    }

    // Floating nodes
    for (int i = 0; i < nodes.length; i++) {
      final movement = math.sin((animationValue * 2 * math.pi) + i);

      final position = Offset(nodes[i].dx, nodes[i].dy + movement * 5);

      final color = [
        AppColors.primary,
        AppColors.secondary,
        AppColors.teal,
        AppColors.coral,
      ][i % 4];

      final outerPaint = Paint()..color = color.withValues(alpha: 0.08);

      canvas.drawCircle(position, 18, outerPaint);

      final innerPaint = Paint()..color = color.withValues(alpha: 0.18);

      canvas.drawCircle(position, 5, innerPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _CommunityPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
