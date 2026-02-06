import 'package:flutter/material.dart';
import 'package:hersbruck_together/app/theme.dart';

class SummaryCard extends StatelessWidget {
  final int amount;
  final String projectTitle;
  final bool isMonthly;
  final bool isValid;
  final VoidCallback onDonate;
  final VoidCallback onLearnMore;

  const SummaryCard({
    super.key,
    required this.amount,
    required this.projectTitle,
    required this.isMonthly,
    required this.isValid,
    required this.onDonate,
    required this.onLearnMore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withValues(alpha: 0.06),
        border: Border.all(
          color: goldAccent.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Zusammenfassung',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          const SizedBox(height: 16),
          _buildSummaryRow(
            label: 'Betrag',
            value: '$amount €${isMonthly ? ' / Monat' : ''}',
            highlight: true,
          ),
          const SizedBox(height: 10),
          _buildSummaryRow(
            label: 'Projekt',
            value: projectTitle.isNotEmpty ? projectTitle : '—',
          ),
          const SizedBox(height: 10),
          _buildSummaryRow(
            label: 'Zahlungsart',
            value: isMonthly ? 'Monatlich' : 'Einmalig',
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white.withValues(alpha: 0.03),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Colors.white.withValues(alpha: 0.4),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Mit Absenden erklärst du dich mit unseren Spendenrichtlinien einverstanden. Dies ist eine Demo.',
                    style: TextStyle(
                      fontSize: 11,
                      height: 1.4,
                      color: Colors.white.withValues(alpha: 0.45),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isValid ? onDonate : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isValid ? goldAccent : Colors.grey.shade800,
                foregroundColor: isValid ? Colors.black : Colors.grey.shade500,
                disabledBackgroundColor: Colors.white.withValues(alpha: 0.08),
                disabledForegroundColor: Colors.white.withValues(alpha: 0.3),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                'Jetzt spenden',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isValid ? Colors.black : Colors.white.withValues(alpha: 0.4),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: TextButton(
              onPressed: onLearnMore,
              child: Text(
                'Mehr über Projekte',
                style: TextStyle(
                  fontSize: 13,
                  color: goldAccent.withValues(alpha: 0.8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow({
    required String label,
    required String value,
    bool highlight = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: highlight ? FontWeight.w600 : FontWeight.w500,
            color: highlight ? goldAccent : Colors.white.withValues(alpha: 0.9),
          ),
        ),
      ],
    );
  }
}
