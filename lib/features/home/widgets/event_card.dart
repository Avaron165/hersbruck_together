import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hersbruck_together/app/theme.dart';
import 'package:hersbruck_together/data/models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({
    super.key,
    required this.event,
  });

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _formatTimeRange() {
    final start = _formatTime(event.startsAt);
    if (event.endsAt != null) {
      final end = _formatTime(event.endsAt!);
      return '$start – $end';
    }
    return start;
  }

  String _formatDatePrefix() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final eventDate = DateTime(
      event.startsAt.year,
      event.startsAt.month,
      event.startsAt.day,
    );
    final tomorrow = today.add(const Duration(days: 1));

    if (eventDate == today) {
      return '';
    } else if (eventDate == tomorrow) {
      return 'Morgen, ';
    } else {
      const weekdays = [
        'Montag',
        'Dienstag',
        'Mittwoch',
        'Donnerstag',
        'Freitag',
        'Samstag',
        'Sonntag'
      ];
      return '${weekdays[event.startsAt.weekday - 1]}, ';
    }
  }

  @override
  Widget build(BuildContext context) {
    final random = Random(event.id.hashCode);
    final hue = random.nextDouble() * 40 + 20;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.08),
                Colors.white.withValues(alpha: 0.03),
              ],
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      HSLColor.fromAHSL(1, hue, 0.4, 0.3).toColor(),
                      HSLColor.fromAHSL(1, hue + 20, 0.5, 0.2).toColor(),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: goldAccent.withValues(alpha: 0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CustomPaint(
                          painter: _ThumbnailPainter(
                            seed: event.id.hashCode,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          _getCategoryIcon(event.category),
                          color: goldAccent,
                          size: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        event.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${_formatDatePrefix()}${_formatTimeRange()}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: goldAccent.withValues(alpha: 0.8),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              event.location,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withValues(alpha: 0.6),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Feste':
        return Icons.celebration_outlined;
      case 'Kultur':
        return Icons.theater_comedy_outlined;
      case 'Familie':
        return Icons.family_restroom_outlined;
      case 'Freizeit':
        return Icons.sports_tennis_outlined;
      default:
        return Icons.event_outlined;
    }
  }
}

class _ThumbnailPainter extends CustomPainter {
  final int seed;

  _ThumbnailPainter({required this.seed});

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(seed);

    for (int i = 0; i < 12; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 20 + 5;
      final opacity = random.nextDouble() * 0.3 + 0.1;

      final paint = Paint()
        ..color = goldAccent.withValues(alpha: opacity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
