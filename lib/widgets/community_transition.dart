import 'dart:math' as math;
import 'package:flutter/material.dart';

enum CommunityTransitionType { needHelp, canHelp }

class CommunityTransition extends StatefulWidget {
  final VoidCallback onComplete;
  final CommunityTransitionType type;

  const CommunityTransition({
    super.key,
    required this.onComplete,
    required this.type,
  });

  @override
  State<CommunityTransition> createState() => _CommunityTransitionState();
}

class _CommunityTransitionState extends State<CommunityTransition>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: _CommunityTransitionPainter(
                progress: _controller.value,
                type: widget.type,
              ),
              child: const SizedBox.expand(),
            );
          },
        ),
      ),
    );
  }
}

class _CommunityTransitionPainter extends CustomPainter {
  final double progress;
  final CommunityTransitionType type;

  _CommunityTransitionPainter({required this.progress, required this.type});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.55);

    _drawBackground(canvas, size);

    if (type == CommunityTransitionType.needHelp) {
      _drawNeedHelpParticles(canvas, size, center);
    } else {
      _drawCanHelpParticles(canvas, size, center);
    }

    _drawCommunityTree(canvas, size, center);

    _drawNodes(canvas, size, center);

    _drawFinalGlow(canvas, size, center);
  }

  // ------------------------------------------------------------
  // BACKGROUND
  // ------------------------------------------------------------

  void _drawBackground(Canvas canvas, Size size) {
    final opacity = Curves.easeInOut.transform(progress.clamp(0.0, 1.0));

    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF06172F).withValues(alpha: opacity * 0.98),
          const Color(0xFF063D59).withValues(alpha: opacity * 0.98),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Offset.zero & size, paint);
  }

  // ------------------------------------------------------------
  // I NEED HELP
  // ------------------------------------------------------------

  void _drawNeedHelpParticles(Canvas canvas, Size size, Offset center) {
    final random = math.Random(100);

    final particleProgress = Curves.easeInOut.transform(
      ((progress - 0.05) / 0.72).clamp(0.0, 1.0),
    );

    for (int i = 0; i < 55; i++) {
      final startX = random.nextDouble() * size.width;

      final startY = random.nextDouble() * size.height;

      final start = Offset(startX, startY);

      final angle = random.nextDouble() * math.pi * 2;

      final targetRadius = size.width * (0.03 + random.nextDouble() * 0.22);

      final target = Offset(
        center.dx + math.cos(angle) * targetRadius,
        center.dy + math.sin(angle) * targetRadius,
      );

      final x = start.dx + (target.dx - start.dx) * particleProgress;

      final y = start.dy + (target.dy - start.dy) * particleProgress;

      final radius = 0.8 + random.nextDouble() * 1.8;

      final paint = Paint()
        ..color = const Color(
          0xFF8DEFFF,
        ).withValues(alpha: 0.7 * particleProgress);

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  // ------------------------------------------------------------
  // I CAN HELP
  // ------------------------------------------------------------

  void _drawCanHelpParticles(Canvas canvas, Size size, Offset center) {
    final random = math.Random(200);

    final particleProgress = Curves.easeOutCubic.transform(
      ((progress - 0.05) / 0.75).clamp(0.0, 1.0),
    );

    final burstProgress = Curves.easeOutCubic.transform(
      ((progress - 0.12) / 0.50).clamp(0.0, 1.0),
    );

    for (int i = 0; i < 55; i++) {
      final angle = random.nextDouble() * math.pi * 2;

      final maxDistance = size.width * (0.25 + random.nextDouble() * 0.42);

      final distance = maxDistance * burstProgress;

      final x = center.dx + math.cos(angle) * distance;

      final y = center.dy + math.sin(angle) * distance;

      final radius = 0.8 + random.nextDouble() * 1.8;

      final paint = Paint()
        ..color = const Color(
          0xFF8DEFFF,
        ).withValues(alpha: 0.75 * particleProgress);

      canvas.drawCircle(Offset(x, y), radius, paint);
    }

    // Central helping node.
    final centralProgress = Curves.elasticOut.transform(
      ((progress - 0.05) / 0.30).clamp(0.0, 1.0),
    );

    final glow = Paint()
      ..color = const Color(
        0xFF50E7FF,
      ).withValues(alpha: 0.35 * centralProgress)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);

    canvas.drawCircle(center, 12 * centralProgress, glow);

    final nodePaint = Paint()
      ..color = Colors.white.withValues(alpha: centralProgress);

    canvas.drawCircle(center, 5 * centralProgress, nodePaint);
  }

  // ------------------------------------------------------------
  // COMMUNITY NETWORK / TREE
  // ------------------------------------------------------------

  void _drawCommunityTree(Canvas canvas, Size size, Offset center) {
    final treeProgress = Curves.easeOutCubic.transform(
      ((progress - 0.22) / 0.60).clamp(0.0, 1.0),
    );

    final branchPaint = Paint()
      ..color = const Color(0xFF65E7FF).withValues(alpha: treeProgress * 0.85)
      ..strokeWidth = 2.7
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final glowPaint = Paint()
      ..color = const Color(0xFF35DFFF).withValues(alpha: treeProgress * 0.22)
      ..strokeWidth = 9
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    final trunkBottom = Offset(center.dx, size.height * 0.91);

    final trunkTop = Offset(center.dx, size.height * 0.51);

    _drawLine(
      canvas,
      trunkBottom,
      trunkTop,
      treeProgress,
      branchPaint,
      glowPaint,
    );

    final branches = [
      [trunkTop, Offset(center.dx - size.width * 0.21, size.height * 0.37)],
      [trunkTop, Offset(center.dx + size.width * 0.21, size.height * 0.37)],
      [
        Offset(center.dx - size.width * 0.08, size.height * 0.43),
        Offset(center.dx - size.width * 0.16, size.height * 0.25),
      ],
      [
        Offset(center.dx + size.width * 0.08, size.height * 0.43),
        Offset(center.dx + size.width * 0.16, size.height * 0.25),
      ],
      [
        Offset(center.dx - size.width * 0.13, size.height * 0.42),
        Offset(center.dx - size.width * 0.29, size.height * 0.31),
      ],
      [
        Offset(center.dx + size.width * 0.13, size.height * 0.42),
        Offset(center.dx + size.width * 0.29, size.height * 0.31),
      ],
      [
        Offset(center.dx - size.width * 0.04, size.height * 0.34),
        Offset(center.dx - size.width * 0.07, size.height * 0.19),
      ],
      [
        Offset(center.dx + size.width * 0.04, size.height * 0.34),
        Offset(center.dx + size.width * 0.07, size.height * 0.19),
      ],
    ];

    for (final branch in branches) {
      _drawLine(
        canvas,
        branch[0],
        branch[1],
        treeProgress,
        branchPaint,
        glowPaint,
      );
    }
  }

  void _drawLine(
    Canvas canvas,
    Offset start,
    Offset end,
    double progress,
    Paint branchPaint,
    Paint glowPaint,
  ) {
    final current = Offset(
      start.dx + (end.dx - start.dx) * progress,
      start.dy + (end.dy - start.dy) * progress,
    );

    canvas.drawLine(start, current, glowPaint);

    canvas.drawLine(start, current, branchPaint);
  }

  // ------------------------------------------------------------
  // COMMUNITY NODES
  // ------------------------------------------------------------

  void _drawNodes(Canvas canvas, Size size, Offset center) {
    final nodeProgress = Curves.elasticOut.transform(
      ((progress - 0.55) / 0.30).clamp(0.0, 1.0),
    );

    final nodes = [
      Offset(center.dx, size.height * 0.51),
      Offset(center.dx - size.width * 0.21, size.height * 0.37),
      Offset(center.dx + size.width * 0.21, size.height * 0.37),
      Offset(center.dx - size.width * 0.16, size.height * 0.25),
      Offset(center.dx + size.width * 0.16, size.height * 0.25),
      Offset(center.dx - size.width * 0.29, size.height * 0.31),
      Offset(center.dx + size.width * 0.29, size.height * 0.31),
      Offset(center.dx - size.width * 0.07, size.height * 0.19),
      Offset(center.dx + size.width * 0.07, size.height * 0.19),
    ];

    for (final node in nodes) {
      final glow = Paint()
        ..color = const Color(0xFF4AE5FF).withValues(alpha: 0.25 * nodeProgress)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 13);

      canvas.drawCircle(node, 15 * nodeProgress, glow);

      final nodePaint = Paint()
        ..color = const Color(0xFFBDF8FF).withValues(alpha: nodeProgress);

      canvas.drawCircle(node, 5 * nodeProgress, nodePaint);

      final corePaint = Paint()
        ..color = Colors.white.withValues(alpha: nodeProgress);

      canvas.drawCircle(node, 1.8 * nodeProgress, corePaint);
    }
  }

  // ------------------------------------------------------------
  // FINAL GLOW
  // ------------------------------------------------------------

  void _drawFinalGlow(Canvas canvas, Size size, Offset center) {
    final glowProgress = Curves.easeOut.transform(
      ((progress - 0.68) / 0.32).clamp(0.0, 1.0),
    );

    final paint = Paint()
      ..color = const Color(
        0xFF4AE6FF,
      ).withValues(alpha: 0.13 * (1 - glowProgress))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 45);

    canvas.drawCircle(center, size.width * (0.15 + glowProgress * 0.75), paint);
  }

  @override
  bool shouldRepaint(covariant _CommunityTransitionPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.type != type;
  }
}
