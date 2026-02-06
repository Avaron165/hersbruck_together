import 'package:flutter/material.dart';
import 'package:hersbruck_together/app/theme.dart';
import 'package:hersbruck_together/features/start/models/sponsor.dart';

/// Premium sponsor carousel with horizontal paging and pagination dots.
class SponsorCarousel extends StatefulWidget {
  final List<Sponsor> sponsors;

  const SponsorCarousel({
    super.key,
    required this.sponsors,
  });

  @override
  State<SponsorCarousel> createState() => _SponsorCarouselState();
}

class _SponsorCarouselState extends State<SponsorCarousel> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.88);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showSponsorDetail(BuildContext context, Sponsor sponsor) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _SponsorDetailSheet(sponsor: sponsor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        _buildSectionHeader(),
        const SizedBox(height: 16),
        // Carousel
        SizedBox(
          height: 140,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: widget.sponsors.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _SponsorCard(
                  sponsor: widget.sponsors[index],
                  onTap: () => _showSponsorDetail(context, widget.sponsors[index]),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 14),
        // Pagination dots
        _buildPaginationDots(),
      ],
    );
  }

  Widget _buildSectionHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.handshake_outlined,
              size: 18,
              color: goldAccent.withValues(alpha: 0.7),
            ),
            const SizedBox(width: 8),
            const Text(
              'Partner & Sponsoren',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Danke für eure Unterstützung',
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }

  Widget _buildPaginationDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.sponsors.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 20 : 8,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: _currentPage == index
                ? goldAccent.withValues(alpha: 0.8)
                : Colors.white.withValues(alpha: 0.2),
          ),
        ),
      ),
    );
  }
}

/// Individual sponsor card with glass/outline styling.
class _SponsorCard extends StatelessWidget {
  final Sponsor sponsor;
  final VoidCallback onTap;

  const _SponsorCard({
    required this.sponsor,
    required this.onTap,
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
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white.withValues(alpha: 0.04),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.08),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // Logo/icon area
              _buildLogoArea(),
              const SizedBox(width: 14),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Tier badge
                    _buildTierBadge(),
                    const SizedBox(height: 6),
                    // Sponsor name
                    Text(
                      sponsor.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Tagline
                    Text(
                      sponsor.tagline,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // Arrow hint
              Icon(
                Icons.chevron_right,
                size: 20,
                color: goldAccent.withValues(alpha: 0.4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoArea() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: goldAccent.withValues(alpha: 0.1),
        border: Border.all(
          color: goldAccent.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Icon(
        sponsor.icon,
        size: 26,
        color: goldAccent.withValues(alpha: 0.8),
      ),
    );
  }

  Widget _buildTierBadge() {
    final isGold = sponsor.tier == SponsorTier.gold;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: isGold
            ? goldAccent.withValues(alpha: 0.15)
            : Colors.white.withValues(alpha: 0.06),
        border: Border.all(
          color: isGold
              ? goldAccent.withValues(alpha: 0.3)
              : Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Text(
        sponsor.tierLabel,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: isGold ? goldAccent : Colors.white.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}

/// Bottom sheet for sponsor details.
class _SponsorDetailSheet extends StatelessWidget {
  final Sponsor sponsor;

  const _SponsorDetailSheet({required this.sponsor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFF1a1a1e),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Colors.white.withValues(alpha: 0.2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Logo
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: goldAccent.withValues(alpha: 0.12),
                    border: Border.all(
                      color: goldAccent.withValues(alpha: 0.25),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    sponsor.icon,
                    size: 34,
                    color: goldAccent,
                  ),
                ),
                const SizedBox(height: 16),
                // Tier badge
                _buildTierBadge(),
                const SizedBox(height: 12),
                // Name
                Text(
                  sponsor.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                // Tagline
                Text(
                  sponsor.tagline,
                  style: TextStyle(
                    fontSize: 14,
                    color: goldAccent.withValues(alpha: 0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                // Description
                Text(
                  sponsor.description,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                // Close button
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.white.withValues(alpha: 0.06),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                    ),
                    child: Text(
                      'Schließen',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTierBadge() {
    final isGold = sponsor.tier == SponsorTier.gold;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isGold
            ? goldAccent.withValues(alpha: 0.15)
            : Colors.white.withValues(alpha: 0.06),
        border: Border.all(
          color: isGold
              ? goldAccent.withValues(alpha: 0.3)
              : Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Text(
        sponsor.tierLabel,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: isGold ? goldAccent : Colors.white.withValues(alpha: 0.6),
        ),
      ),
    );
  }
}
