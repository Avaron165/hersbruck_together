import 'package:flutter/material.dart';
import 'package:hersbruck_together/app/routes.dart';
import 'package:hersbruck_together/app/theme.dart';
import 'package:hersbruck_together/features/start/widgets/feature_tile.dart';
import 'package:hersbruck_together/ui/widgets/elegant_background.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  void _navigateToTab(BuildContext context, int tabIndex) {
    Navigator.of(context).pushReplacementNamed(
      Routes.home,
      arguments: {'initialTabIndex': tabIndex},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElegantBackground(
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 48, 24, 0),
                      child: _buildHeader(),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
                    sliver: _buildTileGrid(context),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                      child: _buildFooter(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: goldAccent.withValues(alpha: 0.15),
            border: Border.all(
              color: goldAccent.withValues(alpha: 0.3),
              width: 2,
            ),
          ),
          child: Icon(
            Icons.location_city,
            size: 36,
            color: goldAccent,
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

  Widget _buildTileGrid(BuildContext context) {
    final tiles = [
      _TileData(
        icon: Icons.event,
        title: 'Events',
        description: 'Veranstaltungen in Hersbruck entdecken',
        tabIndex: 0,
      ),
      _TileData(
        icon: Icons.map,
        title: 'Karte',
        description: 'Orte und Events auf der Karte',
        tabIndex: 1,
      ),
      _TileData(
        icon: Icons.newspaper,
        title: 'News',
        description: 'Neuigkeiten aus der Region',
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
            onTap: () => _navigateToTab(context, tile.tabIndex),
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
