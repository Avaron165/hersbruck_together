import 'package:flutter/material.dart';
import 'package:hersbruck_together/app/theme.dart';
import 'package:hersbruck_together/data/models/event.dart';
import 'package:hersbruck_together/ui/widgets/elegant_background.dart';

class EventDetailPage extends StatefulWidget {
  final Event event;

  const EventDetailPage({super.key, required this.event});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  bool _isBookmarked = false;

  String _formatDate(DateTime dateTime) {
    const weekdays = [
      'Montag',
      'Dienstag',
      'Mittwoch',
      'Donnerstag',
      'Freitag',
      'Samstag',
      'Sonntag'
    ];
    const months = [
      'Januar',
      'Februar',
      'März',
      'April',
      'Mai',
      'Juni',
      'Juli',
      'August',
      'September',
      'Oktober',
      'November',
      'Dezember'
    ];
    final weekday = weekdays[dateTime.weekday - 1];
    final month = months[dateTime.month - 1];
    return '$weekday, ${dateTime.day}. $month ${dateTime.year}';
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} Uhr';
  }

  String _formatDuration() {
    if (widget.event.endsAt == null) return '';
    final duration = widget.event.endsAt!.difference(widget.event.startsAt);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    if (hours > 0 && minutes > 0) {
      return '$hours Std. $minutes Min.';
    } else if (hours > 0) {
      return '$hours Stunden';
    } else {
      return '$minutes Minuten';
    }
  }

  String _generateDescription() {
    return 'Erleben Sie "${widget.event.title}" in ${widget.event.location}. '
        'Ein besonderes Event der Kategorie ${widget.event.category}, '
        'das Sie nicht verpassen sollten. Kommen Sie vorbei und genießen Sie '
        'einen unvergesslichen Moment in Hersbruck.';
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: darkBackground,
      body: ElegantBackground(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _buildHeroSection(context),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                child: _buildInfoSection(
                  icon: Icons.calendar_today_outlined,
                  title: 'Datum & Uhrzeit',
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatDate(widget.event.startsAt),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            _formatTime(widget.event.startsAt),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                          if (widget.event.endsAt != null) ...[
                            Text(
                              ' – ${_formatTime(widget.event.endsAt!)}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withValues(alpha: 0.7),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: goldAccent.withValues(alpha: 0.15),
                              ),
                              child: Text(
                                _formatDuration(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: goldAccent,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                child: _buildInfoSection(
                  icon: Icons.location_on_outlined,
                  title: 'Veranstaltungsort',
                  content: Text(
                    widget.event.location,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                child: _buildInfoSection(
                  icon: Icons.info_outline,
                  title: 'Über das Event',
                  content: Text(
                    _generateDescription(),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.8),
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 12, 20, 24 + bottomPadding),
                child: _buildActionButtons(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return SizedBox(
      height: 300 + topPadding,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (widget.event.imageUrl != null)
            Image.network(
              widget.event.imageUrl!,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: const Color(0xFF1A1A22),
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: goldAccent.withValues(alpha: 0.5),
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFF1A1A22),
                  child: Icon(
                    Icons.image_outlined,
                    size: 48,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                );
              },
            )
          else
            Container(
              color: const Color(0xFF1A1A22),
              child: Icon(
                Icons.image_outlined,
                size: 48,
                color: Colors.white.withValues(alpha: 0.2),
              ),
            ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.3),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.8),
                ],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
          ),
          Positioned(
            top: topPadding + 8,
            left: 8,
            child: _buildBackButton(context),
          ),
          Positioned(
            top: topPadding + 8,
            right: 8,
            child: _buildBookmarkButton(),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: goldAccent.withValues(alpha: 0.9),
                  ),
                  child: Text(
                    widget.event.category,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.event.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withValues(alpha: 0.4),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }

  Widget _buildBookmarkButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isBookmarked = !_isBookmarked;
        });
      },
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withValues(alpha: 0.4),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Icon(
          _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
          color: _isBookmarked ? goldAccent : Colors.white,
          size: 22,
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required IconData icon,
    required String title,
    required Widget content,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white.withValues(alpha: 0.04),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: goldAccent.withValues(alpha: 0.8),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withValues(alpha: 0.5),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          content,
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            icon: Icons.directions_outlined,
            label: 'Route',
            isPrimary: false,
            onTap: () {},
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionButton(
            icon: Icons.event_available_outlined,
            label: 'Zum Event',
            isPrimary: true,
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required bool isPrimary,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: isPrimary
              ? goldAccent
              : Colors.white.withValues(alpha: 0.04),
          border: Border.all(
            color: isPrimary
                ? goldAccent
                : Colors.white.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isPrimary ? Colors.black : Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isPrimary ? Colors.black : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
