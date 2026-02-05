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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white.withValues(alpha: 0.04),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFF1A1A22),
            ),
            clipBehavior: Clip.antiAlias,
            child: event.imageUrl != null
                ? Image.network(
                    event.imageUrl!,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: const Color(0xFF1A1A22),
                        child: Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: goldAccent.withValues(alpha: 0.5),
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFF1A1A22),
                        child: Icon(
                          _getCategoryIcon(event.category),
                          color: goldAccent.withValues(alpha: 0.4),
                          size: 32,
                        ),
                      );
                    },
                  )
                : Container(
                    color: const Color(0xFF1A1A22),
                    child: Icon(
                      _getCategoryIcon(event.category),
                      color: goldAccent.withValues(alpha: 0.4),
                      size: 32,
                    ),
                  ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 4,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${_formatDatePrefix()}${_formatTimeRange()}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 13,
                        color: goldAccent.withValues(alpha: 0.7),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event.location,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.5),
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
          const SizedBox(width: 12),
        ],
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
