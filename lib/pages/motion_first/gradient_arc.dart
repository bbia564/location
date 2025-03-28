import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:motion_record/main.dart';

class ArcProgress extends StatelessWidget {
  final double progress;
  final double size;

  const ArcProgress({
    super.key,
    required this.progress,
    this.size = 200,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _ArcPainter(progress: progress),
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double progress;

  _ArcPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final currentProgress = progress.clamp(0.0, 1.0);
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2);

    const backgroundStartAngle = 135 * math.pi / 180;
    const backgroundSweepAngle = (360-90) * math.pi / 180;

    final progressSweepAngle = backgroundSweepAngle * currentProgress;

    final backgroundPaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      backgroundStartAngle,
      backgroundSweepAngle,
      false,
      backgroundPaint,
    );

    final progressPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      backgroundStartAngle,
      progressSweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
