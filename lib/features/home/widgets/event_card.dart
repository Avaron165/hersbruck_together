import 'package:flutter/material.dart';
import 'package:hersbruck_together/data/models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final bool isBookmarked;
  final VoidCallback onBookmarkToggle;

  const EventCard({
    super.key,
    required this.event,
    required this.isBookmarked,
    required this.onBookmarkToggle,
  });

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Kultur':
        return Icons.museum_outlined;
      case 'Sport':
        return Icons.sports_soccer_outlined;
      case 'Familie':
        return Icons.family_restroom_outlined;
      case 'Musik':
        return Icons.music_note_outlined;
      case 'Essen':
        return Icons.restaurant_outlined;
      case 'Natur':
        return Icons.park_outlined;
      default:
        return Icons.event_outlined;
    }
  }

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final eventDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    final tomorrow = today.add(const Duration(days: 1));

    final time =
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

    if (eventDate == today) {
      return 'Heute • $time';
    } else if (eventDate == tomorrow) {
      return 'Morgen • $time';
    } else {
      const weekdays = ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];
      const months = [
        'Jan',
        'Feb',
        'Mär',
        'Apr',
        'Mai',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Okt',
        'Nov',
        'Dez'
      ];
      final weekday = weekdays[dateTime.weekday - 1];
      final month = months[dateTime.month - 1];
      return '$weekday, ${dateTime.day}. $month • $time';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0,
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getCategoryIcon(event.category),
                color: colorScheme.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.secondaryContainer.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      event.category,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSecondaryContainer,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    event.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule_outlined,
                        size: 16,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatDate(event.startsAt),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event.location,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                color: isBookmarked
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
              onPressed: onBookmarkToggle,
            ),
          ],
        ),
      ),
    );
  }
}
