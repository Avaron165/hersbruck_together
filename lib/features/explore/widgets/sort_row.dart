import 'package:flutter/material.dart';
import 'package:hersbruck_together/app/theme.dart';
import 'package:hersbruck_together/features/explore/models/poi.dart';

/// Sorting control row for POI list
class SortRow extends StatelessWidget {
  final PoiSortOption selectedOption;
  final ValueChanged<PoiSortOption> onOptionSelected;

  const SortRow({
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
            fontSize: 13,
            color: Colors.white.withValues(alpha: 0.5),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _SortChip(
                  label: 'Beliebt',
                  icon: Icons.trending_up,
                  isSelected: selectedOption == PoiSortOption.popular,
                  onTap: () => onOptionSelected(PoiSortOption.popular),
                ),
                const SizedBox(width: 8),
                _SortChip(
                  label: 'In der Nähe',
                  icon: Icons.near_me,
                  isSelected: selectedOption == PoiSortOption.nearby,
                  onTap: () => onOptionSelected(PoiSortOption.nearby),
                ),
                const SizedBox(width: 8),
                _SortChip(
                  label: 'A–Z',
                  icon: Icons.sort_by_alpha,
                  isSelected: selectedOption == PoiSortOption.alphabetical,
                  onTap: () => onOptionSelected(PoiSortOption.alphabetical),
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
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isSelected
                ? goldAccent.withValues(alpha: 0.15)
                : Colors.white.withValues(alpha: 0.04),
            border: Border.all(
              color: isSelected
                  ? goldAccent.withValues(alpha: 0.4)
                  : Colors.white.withValues(alpha: 0.08),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 14,
                color: isSelected
                    ? goldAccent
                    : Colors.white.withValues(alpha: 0.5),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? goldAccent
                      : Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
