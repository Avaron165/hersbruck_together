import 'package:flutter/material.dart';
import 'package:hersbruck_together/app/theme.dart';
import 'package:hersbruck_together/features/explore/models/poi.dart';

/// Premium card for displaying a Point of Interest
class PoiCard extends StatelessWidget {
  final Poi poi;
  final VoidCallback onTap;
  final double? distance; // Distance in km, shown when sorting by nearby

  const PoiCard({
    super.key,
    required this.poi,
    required this.onTap,
    this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: goldAccent.withValues(alpha: 0.1),
        highlightColor: goldAccent.withValues(alpha: 0.05),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white.withValues(alpha: 0.04),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.08),
              width: 1,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image section
              _buildImageSection(),
              // Content section
              Padding(
                padding: const EdgeInsets.all(14),
                child: _buildContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        // Image
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.network(
            poi.imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                color: Colors.white.withValues(alpha: 0.05),
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                    strokeWidth: 2,
                    color: goldAccent.withValues(alpha: 0.5),
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.white.withValues(alpha: 0.05),
                child: Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.white.withValues(alpha: 0.3),
                    size: 32,
                  ),
                ),
              );
            },
          ),
        ),
        // Gradient overlay
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.6),
                ],
                stops: const [0.5, 1.0],
              ),
            ),
          ),
        ),
        // Category badge
        Positioned(
          top: 10,
          left: 10,
          child: _buildCategoryBadge(),
        ),
        // Distance badge (if showing)
        if (distance != null)
          Positioned(
            top: 10,
            right: 10,
            child: _buildDistanceBadge(),
          ),
      ],
    );
  }

  Widget _buildCategoryBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black.withValues(alpha: 0.5),
        border: Border.all(
          color: goldAccent.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getCategoryIcon(),
            size: 12,
            color: goldAccent.withValues(alpha: 0.9),
          ),
          const SizedBox(width: 5),
          Text(
            poi.category,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDistanceBadge() {
    final distanceText = distance! < 1
        ? '${(distance! * 1000).round()} m'
        : '${distance!.toStringAsFixed(1)} km';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: goldAccent.withValues(alpha: 0.15),
        border: Border.all(
          color: goldAccent.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.near_me,
            size: 12,
            color: goldAccent,
          ),
          const SizedBox(width: 4),
          Text(
            distanceText,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: goldAccent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          poi.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        // Short description
        Text(
          poi.descriptionShort,
          style: TextStyle(
            fontSize: 13,
            height: 1.4,
            color: Colors.white.withValues(alpha: 0.65),
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 10),
        // Footer with opening hours and arrow
        Row(
          children: [
            if (poi.openingHours != null) ...[
              Icon(
                Icons.schedule,
                size: 13,
                color: Colors.white.withValues(alpha: 0.4),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  poi.openingHours!,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ] else
              const Spacer(),
            Icon(
              Icons.arrow_forward,
              size: 16,
              color: goldAccent.withValues(alpha: 0.6),
            ),
          ],
        ),
      ],
    );
  }

  IconData _getCategoryIcon() {
    switch (poi.category) {
      case 'Museum':
        return Icons.museum;
      case 'Altstadt':
        return Icons.location_city;
      case 'Aussicht':
        return Icons.landscape;
      case 'Kirche':
        return Icons.church;
      case 'Natur':
        return Icons.park;
      default:
        return Icons.place;
    }
  }
}
