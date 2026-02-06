import 'package:flutter/material.dart';
import 'package:hersbruck_together/app/theme.dart';
import 'package:hersbruck_together/features/actions/models/action_item.dart';

/// Premium card for displaying a partner action/promotion
class ActionCard extends StatelessWidget {
  final ActionItem action;
  final VoidCallback onTap;

  const ActionCard({
    super.key,
    required this.action,
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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white.withValues(alpha: 0.04),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.08),
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image thumbnail
              _buildImage(),
              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: _buildContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
          child: Image.network(
            action.imageUrl,
            width: 110,
            height: 130,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                width: 110,
                height: 130,
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
              width: 110,
              height: 130,
              color: Colors.white.withValues(alpha: 0.05),
              child: Center(
                child: Icon(
                  Icons.local_offer_outlined,
                  color: Colors.white.withValues(alpha: 0.3),
                  size: 28,
                ),
              ),
            ),
          ),
        ),
        // Badge overlay
        Positioned(
          top: 8,
          left: 8,
          child: _buildBadge(),
        ),
      ],
    );
  }

  Widget _buildBadge() {
    final isNewBadge = action.isNew;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: isNewBadge
            ? goldAccent.withValues(alpha: 0.9)
            : Colors.black.withValues(alpha: 0.6),
        border: Border.all(
          color: isNewBadge
              ? goldAccent
              : goldAccent.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        action.badgeText,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: isNewBadge ? Colors.black : goldAccent,
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Partner name
        Text(
          action.partnerName,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: goldAccent.withValues(alpha: 0.7),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        // Title
        Text(
          action.title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            height: 1.3,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        // Short description
        Text(
          action.shortDesc,
          style: TextStyle(
            fontSize: 12,
            height: 1.4,
            color: Colors.white.withValues(alpha: 0.55),
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 10),
        // Footer with validity and CTA
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(
                    action.isEndingSoon
                        ? Icons.timer_outlined
                        : Icons.schedule,
                    size: 12,
                    color: action.isEndingSoon
                        ? Colors.orange.withValues(alpha: 0.7)
                        : Colors.white.withValues(alpha: 0.4),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      action.validityText,
                      style: TextStyle(
                        fontSize: 10,
                        color: action.isEndingSoon
                            ? Colors.orange.withValues(alpha: 0.7)
                            : Colors.white.withValues(alpha: 0.4),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            // Subtle CTA
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Details',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: goldAccent.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(width: 2),
                Icon(
                  Icons.chevron_right,
                  size: 14,
                  color: goldAccent.withValues(alpha: 0.5),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
