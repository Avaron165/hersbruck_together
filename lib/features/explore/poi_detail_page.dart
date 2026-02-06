import 'package:flutter/material.dart';
import 'package:hersbruck_together/app/theme.dart';
import 'package:hersbruck_together/features/explore/models/poi.dart';
import 'package:hersbruck_together/ui/widgets/elegant_background.dart';

/// Detail page for a Point of Interest
class PoiDetailPage extends StatelessWidget {
  final Poi poi;
  final VoidCallback? onShowOnMap;

  const PoiDetailPage({
    super.key,
    required this.poi,
    this.onShowOnMap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElegantBackground(
        child: CustomScrollView(
          slivers: [
            // Hero image app bar
            _buildSliverAppBar(context),
            // Content
            SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                    child: _buildContent(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: const Color(0xFF0A0A0E),
      leading: _buildBackButton(context),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Hero image
            Image.network(
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
              errorBuilder: (_, __, ___) => Container(
                color: Colors.white.withValues(alpha: 0.05),
                child: Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 48,
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                ),
              ),
            ),
            // Gradient overlay
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    const Color(0xFF0A0A0E).withValues(alpha: 0.8),
                    const Color(0xFF0A0A0E),
                  ],
                  stops: const [0.3, 0.7, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white.withValues(alpha: 0.9),
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category badge
        _buildCategoryBadge(),
        const SizedBox(height: 12),
        // Title
        Text(
          poi.name,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        // Short description
        Text(
          poi.descriptionShort,
          style: TextStyle(
            fontSize: 15,
            height: 1.5,
            color: goldAccent.withValues(alpha: 0.85),
          ),
        ),
        const SizedBox(height: 20),
        // Info row (opening hours, location)
        _buildInfoRow(),
        const SizedBox(height: 24),
        // Action buttons
        _buildActionButtons(context),
        const SizedBox(height: 32),
        // Long description
        _buildLongDescription(),
      ],
    );
  }

  Widget _buildCategoryBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: goldAccent.withValues(alpha: 0.15),
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
            size: 14,
            color: goldAccent,
          ),
          const SizedBox(width: 6),
          Text(
            poi.category,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: goldAccent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow() {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: [
        if (poi.openingHours != null)
          _InfoChip(
            icon: Icons.schedule,
            label: poi.openingHours!,
          ),
        if (poi.websiteUrl != null)
          _InfoChip(
            icon: Icons.language,
            label: 'Website',
          ),
        _InfoChip(
          icon: Icons.location_on_outlined,
          label: 'Hersbruck',
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            icon: Icons.map_outlined,
            label: 'Auf Karte anzeigen',
            isPrimary: true,
            onTap: () {
              Navigator.of(context).pop({'showOnMap': true, 'poi': poi});
            },
          ),
        ),
        const SizedBox(width: 12),
        _ActionButton(
          icon: Icons.share_outlined,
          label: 'Teilen',
          isPrimary: false,
          onTap: () {
            // Mock: Show snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Teilen: ${poi.name}'),
                backgroundColor: const Color(0xFF1a1a1e),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLongDescription() {
    // Parse the long description into sections
    final sections = poi.descriptionLong.split('\n\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < sections.length; i++) ...[
          if (i > 0) const SizedBox(height: 20),
          _buildSection(sections[i]),
        ],
      ],
    );
  }

  Widget _buildSection(String text) {
    // Check if the section starts with a header (ending with :)
    final lines = text.split('\n');
    final firstLine = lines.first;

    if (firstLine.endsWith(':') && lines.length > 1) {
      // This is a header section
      final headerText = firstLine.substring(0, firstLine.length - 1);
      final bodyText = lines.skip(1).join('\n');

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white.withValues(alpha: 0.03),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.06),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: goldAccent.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  headerText,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              bodyText,
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      );
    } else {
      // Regular paragraph
      return Text(
        text,
        style: TextStyle(
          fontSize: 14,
          height: 1.6,
          color: Colors.white.withValues(alpha: 0.7),
        ),
      );
    }
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

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.white.withValues(alpha: 0.4),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isPrimary
                ? goldAccent.withValues(alpha: 0.15)
                : Colors.white.withValues(alpha: 0.04),
            border: Border.all(
              color: isPrimary
                  ? goldAccent.withValues(alpha: 0.3)
                  : Colors.white.withValues(alpha: 0.08),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 18,
                color: isPrimary
                    ? goldAccent
                    : Colors.white.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isPrimary
                      ? goldAccent
                      : Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
