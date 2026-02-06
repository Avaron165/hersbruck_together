import 'package:flutter/material.dart';
import 'package:hersbruck_together/app/theme.dart';
import 'package:hersbruck_together/features/actions/models/action_item.dart';

/// Sorting control row for actions list
class ActionSortRow extends StatelessWidget {
  final ActionSortOption selectedOption;
  final ValueChanged<ActionSortOption> onOptionSelected;

  const ActionSortRow({
    super.key,
    required this.selectedOption,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Sortieren:',
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.5),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _SortChip(
                  label: 'Neu zuerst',
                  icon: Icons.fiber_new_outlined,
                  isSelected: selectedOption == ActionSortOption.newest,
                  onTap: () => onOptionSelected(ActionSortOption.newest),
                ),
                const SizedBox(width: 8),
                _SortChip(
                  label: 'Bald endet',
                  icon: Icons.timer_outlined,
                  isSelected: selectedOption == ActionSortOption.endingSoon,
                  onTap: () => onOptionSelected(ActionSortOption.endingSoon),
                ),
                const SizedBox(width: 8),
                _SortChip(
                  label: 'A–Z',
                  icon: Icons.sort_by_alpha,
                  isSelected: selectedOption == ActionSortOption.alphabetical,
                  onTap: () => onOptionSelected(ActionSortOption.alphabetical),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SortChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _SortChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isSelected
                ? goldAccent.withValues(alpha: 0.12)
                : Colors.transparent,
            border: Border.all(
              color: isSelected
                  ? goldAccent.withValues(alpha: 0.3)
                  : Colors.white.withValues(alpha: 0.08),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 12,
                color: isSelected
                    ? goldAccent
                    : Colors.white.withValues(alpha: 0.4),
              ),
              const SizedBox(width: 5),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                  color: isSelected
                      ? goldAccent
                      : Colors.white.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
