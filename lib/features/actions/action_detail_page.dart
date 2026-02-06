import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hersbruck_together/app/theme.dart';
import 'package:hersbruck_together/features/actions/models/action_item.dart';
import 'package:hersbruck_together/ui/widgets/elegant_background.dart';

/// Detail page for a partner action/promotion
class ActionDetailPage extends StatelessWidget {
  final ActionItem action;

  const ActionDetailPage({
    super.key,
    required this.action,
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
      expandedHeight: 240,
      pinned: true,
      backgroundColor: const Color(0xFF0A0A0E),
      leading: _buildBackButton(context),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Hero image
            Image.network(
              action.imageUrl,
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
                    Icons.local_offer_outlined,
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
                    const Color(0xFF0A0A0E).withValues(alpha: 0.7),
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
        // Partner and badge row
        Row(
          children: [
            _buildTypeBadge(),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                action.partnerName,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: goldAccent.withValues(alpha: 0.8),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Title
        Text(
          action.title,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        // Validity
        Row(
          children: [
            Icon(
              action.isEndingSoon
                  ? Icons.timer_outlined
                  : Icons.schedule,
              size: 16,
              color: action.isEndingSoon
                  ? Colors.orange.withValues(alpha: 0.8)
                  : Colors.white.withValues(alpha: 0.5),
            ),
            const SizedBox(width: 6),
            Text(
              action.validityText,
              style: TextStyle(
                fontSize: 13,
                color: action.isEndingSoon
                    ? Colors.orange.withValues(alpha: 0.8)
                    : Colors.white.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Redeem code section (if available)
        if (action.redeemCode != null) ...[
          _buildRedeemSection(context),
          const SizedBox(height: 24),
        ],
        // Long description
        _buildDescriptionSection(),
        const SizedBox(height: 20),
        // How it works
        _buildHowItWorksSection(),
        const SizedBox(height: 24),
        // Disclaimer
        _buildDisclaimer(),
      ],
    );
  }

  Widget _buildTypeBadge() {
    final isNewBadge = action.isNew;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isNewBadge
            ? goldAccent.withValues(alpha: 0.9)
            : goldAccent.withValues(alpha: 0.15),
        border: Border.all(
          color: goldAccent.withValues(alpha: isNewBadge ? 1.0 : 0.3),
          width: 1,
        ),
      ),
      child: Text(
        action.badgeText,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: isNewBadge ? Colors.black : goldAccent,
        ),
      ),
    );
  }

  Widget _buildRedeemSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: goldAccent.withValues(alpha: 0.08),
        border: Border.all(
          color: goldAccent.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.qr_code_2,
                size: 18,
                color: goldAccent.withValues(alpha: 0.8),
              ),
              const SizedBox(width: 8),
              Text(
                'Aktionscode',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: goldAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Code box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withValues(alpha: 0.3),
              border: Border.all(
                color: goldAccent.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    action.redeemCode!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () => _copyCode(context),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.copy,
                        size: 20,
                        color: goldAccent.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (action.redeemHint != null) ...[
            const SizedBox(height: 10),
            Text(
              action.redeemHint!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withValues(alpha: 0.5),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _copyCode(BuildContext context) {
    Clipboard.setData(ClipboardData(text: action.redeemCode!));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: goldAccent,
              size: 18,
            ),
            const SizedBox(width: 10),
            const Text('Code kopiert!'),
          ],
        ),
        backgroundColor: const Color(0xFF1a1a1e),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildDescriptionSection() {
    // Parse description into paragraphs
    final paragraphs = action.longDesc.split('\n\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: paragraphs.map((paragraph) {
        // Check if it's a header (ends with :)
        final lines = paragraph.split('\n');
        if (lines.first.endsWith(':')) {
          return _buildSectionCard(
            lines.first.substring(0, lines.first.length - 1),
            lines.skip(1).join('\n'),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text(
            paragraph,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSectionCard(String title, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: Colors.white.withValues(alpha: 0.65),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHowItWorksSection() {
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
              Icon(
                Icons.info_outline,
                size: 18,
                color: goldAccent.withValues(alpha: 0.7),
              ),
              const SizedBox(width: 8),
              const Text(
                'So funktioniert\'s',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _HowToStep(number: 1, text: 'Zeigen Sie diesen Bildschirm beim Partner'),
          const SizedBox(height: 10),
          _HowToStep(
            number: 2,
            text: action.redeemCode != null
                ? 'Nennen Sie den Aktionscode "${action.redeemCode}"'
                : 'Erwähnen Sie die Hersbruck Together App',
          ),
          const SizedBox(height: 10),
          _HowToStep(number: 3, text: 'Erhalten Sie Ihren Vorteil direkt vor Ort'),
        ],
      ),
    );
  }

  Widget _buildDisclaimer() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withValues(alpha: 0.02),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            size: 14,
            color: Colors.white.withValues(alpha: 0.3),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Demo – Einlösung erfolgt beim Partner. Änderungen vorbehalten.',
              style: TextStyle(
                fontSize: 11,
                color: Colors.white.withValues(alpha: 0.35),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HowToStep extends StatelessWidget {
  final int number;
  final String text;

  const _HowToStep({
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: goldAccent.withValues(alpha: 0.15),
            border: Border.all(
              color: goldAccent.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              '$number',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: goldAccent,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
