import 'package:flutter/material.dart';
import 'package:hersbruck_together/app/theme.dart';
import 'package:hersbruck_together/features/start/widgets/feature_tile.dart';

/// Start Page content widget - used as the Home tab in the main shell.
/// Displays app branding, logo, and navigation tiles to other tabs.
class StartPageContent extends StatelessWidget {
  final void Function(int tabIndex) onSelectTab;

  const StartPageContent({
    super.key,
    required this.onSelectTab,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 48, 24, 0),
            child: _buildHeader(),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
          sliver: _buildTileGrid(),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
            child: _buildFooter(),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // App logo from assets
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: goldAccent.withValues(alpha: 0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: goldAccent.withValues(alpha: 0.15),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              'lib/assets/icon/app_icon.png',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Hersbruck Together',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Entdecken • Mitmachen • Unterstützen',
          style: TextStyle(
            fontSize: 14,
            color: goldAccent.withValues(alpha: 0.8),
            letterSpacing: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTileGrid() {
    // Tiles for navigating to other tabs (Events=1, Karte=2, Spenden=3)
    final tiles = [
      _TileData(
        icon: Icons.event,
        title: 'Events',
        description: 'Veranstaltungen in Hersbruck entdecken',
        tabIndex: 1,
      ),
      _TileData(
        icon: Icons.map,
        title: 'Karte',
        description: 'Orte und Events auf der Karte',
        tabIndex: 2,
      ),
      _TileData(
        icon: Icons.favorite,
        title: 'Spenden',
        description: 'Lokale Projekte unterstützen',
        tabIndex: 3,
      ),
    ];

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.95,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final tile = tiles[index];
          return FeatureTile(
            icon: tile.icon,
            title: tile.title,
            description: tile.description,
            onTap: () => onSelectTab(tile.tabIndex),
          );
        },
        childCount: tiles.length,
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white.withValues(alpha: 0.03),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.06),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.handshake_outlined,
                size: 18,
                color: goldAccent.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 10),
              Text(
                'Eine Initiative für unsere Gemeinschaft',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TileData {
  final IconData icon;
  final String title;
  final String description;
  final int tabIndex;

  const _TileData({
    required this.icon,
    required this.title,
    required this.description,
    required this.tabIndex,
  });
}
