import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hersbruck_together/app/theme.dart';

class StarBackground extends StatelessWidget {
  final Widget child;

  const StarBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0D0D12),
            Color(0xFF151520),
            Color(0xFF1A1A28),
          ],
        ),
      ),
      child: CustomPaint(
        painter: _StarPainter(),
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.2,
              colors: [
                Colors.transparent,
                darkBackground.withValues(alpha: 0.3),
                darkBackground.withValues(alpha: 0.7),
              ],
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _StarPainter extends CustomPainter {
  final Random _random = Random(42);

  @override
  void paint(Canvas canvas, Size size) {
    final starCount = (size.width * size.height / 8000).clamp(50, 200).toInt();

    for (int i = 0; i < starCount; i++) {
      final x = _random.nextDouble() * size.width;
      final y = _random.nextDouble() * size.height;
      final radius = _random.nextDouble() * 1.5 + 0.5;
      final opacity = _random.nextDouble() * 0.6 + 0.2;

      final isGolden = _random.nextDouble() > 0.85;
      final color = isGolden
          ? goldAccent.withValues(alpha: opacity)
          : Colors.white.withValues(alpha: opacity);

      final paint = Paint()
        ..color = color
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1);

      canvas.drawCircle(Offset(x, y), radius, paint);

      if (radius > 1.2) {
        final glowPaint = Paint()
          ..color = color.withValues(alpha: opacity * 0.3)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
        canvas.drawCircle(Offset(x, y), radius * 2, glowPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
