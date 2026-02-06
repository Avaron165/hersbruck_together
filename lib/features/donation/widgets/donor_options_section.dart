import 'package:flutter/material.dart';
import 'package:hersbruck_together/app/theme.dart';

class DonorOptionsSection extends StatelessWidget {
  final bool isAnonymous;
  final bool isMonthly;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final ValueChanged<bool> onAnonymousChanged;
  final ValueChanged<bool> onMonthlyChanged;
  final String? nameError;
  final String? emailError;

  const DonorOptionsSection({
    super.key,
    required this.isAnonymous,
    required this.isMonthly,
    required this.nameController,
    required this.emailController,
    required this.onAnonymousChanged,
    required this.onMonthlyChanged,
    this.nameError,
    this.emailError,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Spender-Optionen',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
        const SizedBox(height: 14),
        _buildToggleRow(
          label: 'Anonym spenden',
          subtitle: 'Dein Name wird nicht veröffentlicht',
          value: isAnonymous,
          onChanged: onAnonymousChanged,
        ),
        const SizedBox(height: 12),
        _buildToggleRow(
          label: 'Monatlich spenden',
          subtitle: 'Regelmäßig Gutes tun',
          value: isMonthly,
          onChanged: onMonthlyChanged,
        ),
        if (!isAnonymous) ...[
          const SizedBox(height: 20),
          _buildTextField(
            controller: nameController,
            label: 'Name',
            hint: 'Max Mustermann',
            icon: Icons.person_outline,
            errorText: nameError,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: emailController,
            label: 'E-Mail',
            hint: 'max@beispiel.de',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            errorText: emailError,
          ),
        ],
      ],
    );
  }

  Widget _buildToggleRow({
    required String label,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withValues(alpha: 0.04),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: goldAccent,
            activeTrackColor: goldAccent.withValues(alpha: 0.3),
            inactiveThumbColor: Colors.white.withValues(alpha: 0.6),
            inactiveTrackColor: Colors.white.withValues(alpha: 0.1),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white.withValues(alpha: 0.05),
            border: Border.all(
              color: errorText != null
                  ? Colors.red.withValues(alpha: 0.5)
                  : Colors.white.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.35),
                fontSize: 14,
              ),
              prefixIcon: Icon(
                icon,
                color: Colors.white.withValues(alpha: 0.4),
                size: 20,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            errorText,
            style: TextStyle(
              fontSize: 11,
              color: Colors.red.withValues(alpha: 0.8),
            ),
          ),
        ],
      ],
    );
  }
}
