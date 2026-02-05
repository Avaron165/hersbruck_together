import 'dart:ui';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double blur;
  final bool showBorder;

  const GlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 16,
    this.blur = 10,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.12),
                Colors.white.withValues(alpha: 0.05),
              ],
            ),
            border: showBorder
                ? Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                    width: 1,
                  )
                : null,
          ),
          child: child,
        ),
      ),
    );
  }
}
