import 'package:flutter/material.dart';
import 'package:hersbruck_together/app/theme.dart';
import 'package:hersbruck_together/data/models/ad.dart';

class SponsoredCard extends StatelessWidget {
  final Ad ad;
  final VoidCallback? onTap;
  final VoidCallback? onCta;

  const SponsoredCard({
    super.key,
    required this.ad,
    this.onTap,
    this.onCta,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white.withValues(alpha: 0.04),
          border: Border.all(
            color: goldAccent.withValues(alpha: 0.12),
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 110,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFF1A1A22),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    ad.imageUrl,
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
                          Icons.storefront_outlined,
                          color: goldAccent.withValues(alpha: 0.4),
                          size: 32,
                        ),
                      );
                    },
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
                        const SizedBox(height: 4),
                        Text(
                          ad.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          ad.subtitle,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.5),
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.verified_outlined,
                              size: 12,
                              color: goldAccent.withValues(alpha: 0.6),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                ad.sponsorName,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: goldAccent.withValues(alpha: 0.7),
                                  fontWeight: FontWeight.w500,
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
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: _buildCtaButton(),
                ),
              ],
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white.withValues(alpha: 0.08),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
                child: Text(
                  'Anzeige',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.5),
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCtaButton() {
    return GestureDetector(
      onTap: onCta,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: goldAccent.withValues(alpha: 0.4),
            width: 1,
          ),
        ),
        child: Text(
          ad.ctaLabel,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: goldAccent.withValues(alpha: 0.9),
          ),
        ),
      ),
    );
  }
}
