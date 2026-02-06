import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hersbruck_together/app/theme.dart';

class AmountSelector extends StatelessWidget {
  final int? selectedPresetAmount;
  final String customAmount;
  final TextEditingController customAmountController;
  final ValueChanged<int?> onPresetSelected;
  final ValueChanged<String> onCustomAmountChanged;
  final String? errorText;

  static const List<int> presetAmounts = [5, 10, 25, 50];

  const AmountSelector({
    super.key,
    required this.selectedPresetAmount,
    required this.customAmount,
    required this.customAmountController,
    required this.onPresetSelected,
    required this.onCustomAmountChanged,
    this.errorText,
  });

  bool get isCustomSelected =>
      selectedPresetAmount == null && customAmount.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Betrag wählen',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            ...presetAmounts.map((amount) => _buildPresetChip(amount)),
            _buildCustomChip(),
          ],
        ),
        if (isCustomSelected || selectedPresetAmount == null) ...[
          const SizedBox(height: 14),
          _buildCustomInput(),
        ],
        if (errorText != null) ...[
          const SizedBox(height: 8),
          Text(
            errorText!,
            style: TextStyle(
              fontSize: 12,
              color: Colors.red.withValues(alpha: 0.8),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPresetChip(int amount) {
    final isSelected = selectedPresetAmount == amount;

    return GestureDetector(
      onTap: () => onPresetSelected(amount),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? goldAccent.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.05),
          border: Border.all(
            color: isSelected
                ? goldAccent.withValues(alpha: 0.6)
                : Colors.white.withValues(alpha: 0.1),
            width: 1.5,
          ),
        ),
        child: Text(
          '$amount €',
          style: TextStyle(
            fontSize: 15,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? goldAccent : Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomChip() {
    final isSelected = isCustomSelected;

    return GestureDetector(
      onTap: () => onPresetSelected(null),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? goldAccent.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.05),
          border: Border.all(
            color: isSelected
                ? goldAccent.withValues(alpha: 0.6)
                : Colors.white.withValues(alpha: 0.1),
            width: 1.5,
          ),
        ),
        child: Text(
          'Freier Betrag',
          style: TextStyle(
            fontSize: 15,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? goldAccent : Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomInput() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: TextField(
        controller: customAmountController,
        onChanged: onCustomAmountChanged,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: 'Betrag eingeben (1–500 €)',
          hintStyle: TextStyle(
            color: Colors.white.withValues(alpha: 0.4),
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.euro,
            color: goldAccent.withValues(alpha: 0.6),
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
