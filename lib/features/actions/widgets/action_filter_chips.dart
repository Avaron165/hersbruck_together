import 'package:flutter/material.dart';
import 'package:hersbruck_together/app/theme.dart';
import 'package:hersbruck_together/features/actions/models/action_item.dart';

/// Filter options for action list
enum ActionFilter {
  alle,
  rabatte,
  aktionen,
  neu,
  food,
  sport,
  kultur,
}

extension ActionFilterExtension on ActionFilter {
  String get displayName {
    switch (this) {
      case ActionFilter.alle:
        return 'Alle';
      case ActionFilter.rabatte:
        return 'Rabatte';
      case ActionFilter.aktionen:
        return 'Aktionen';
      case ActionFilter.neu:
        return 'Neu';
      case ActionFilter.food:
        return 'Food';
      case ActionFilter.sport:
        return 'Sport';
      case ActionFilter.kultur:
        return 'Kultur';
    }
  }

  IconData get icon {
    switch (this) {
      case ActionFilter.alle:
        return Icons.all_inclusive;
      case ActionFilter.rabatte:
        return Icons.percent;
      case ActionFilter.aktionen:
        return Icons.local_offer_outlined;
      case ActionFilter.neu:
        return Icons.new_releases_outlined;
      case ActionFilter.food:
        return Icons.restaurant;
      case ActionFilter.sport:
        return Icons.sports;
      case ActionFilter.kultur:
        return Icons.museum_outlined;
    }
  }

  /// Check if an action matches this filter
  bool matches(ActionItem action) {
    switch (this) {
      case ActionFilter.alle:
        return true;
      case ActionFilter.rabatte:
        return action.type == ActionType.rabatt;
      case ActionFilter.aktionen:
        return action.type == ActionType.aktion;
      case ActionFilter.neu:
        return action.isNew;
      case ActionFilter.food:
        return action.category == ActionCategory.food;
      case ActionFilter.sport:
        return action.category == ActionCategory.sport;
      case ActionFilter.kultur:
        return action.category == ActionCategory.kultur;
    }
  }
}

/// Filter chips row for actions list
class ActionFilterChips extends StatelessWidget {
  final ActionFilter selectedFilter;
  final ValueChanged<ActionFilter> onFilterSelected;

  const ActionFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: ActionFilter.values.map((filter) {
          final isSelected = filter == selectedFilter;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _FilterChip(
              label: filter.displayName,
              icon: filter.icon,
              isSelected: isSelected,
              onTap: () => onFilterSelected(filter),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
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
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
