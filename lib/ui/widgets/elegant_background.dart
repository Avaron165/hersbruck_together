import 'package:flutter/material.dart';

class ElegantBackground extends StatelessWidget {
  final Widget child;

  const ElegantBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.3, 1.0],
          colors: [
            Color(0xFF12121A),
            Color(0xFF0F0F14),
            Color(0xFF0A0A0E),
          ],
        ),
      ),
      child: CustomPaint(
        painter: _SpotlightPainter(),
        child: child,
      ),
    );
  }
}

class _SpotlightPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.5, size.height * 0.08);
    final paint = Paint()
      ..shader = RadialGradient(
        center: Alignment.topCenter,
        radius: 0.8,
        colors: [
          const Color(0xFFC9A46A).withValues(alpha: 0.06),
          const Color(0xFFC9A46A).withValues(alpha: 0.02),
          Colors.transparent,
        ],
        stops: const [0.0, 0.4, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: size.width * 0.7));

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height * 0.5),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
