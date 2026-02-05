import 'package:flutter/material.dart';

class CategoryChips extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  static const List<String> categories = [
    'Alle',
    'Kultur',
    'Sport',
    'Familie',
    'Musik',
    'Essen',
    'Natur',
  ];

  const CategoryChips({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;

          return FilterChip(
            label: Text(category),
            selected: isSelected,
            onSelected: (selected) {
              if (selected) {
                onCategorySelected(category);
              }
            },
            selectedColor: colorScheme.primaryContainer,
            checkmarkColor: colorScheme.onPrimaryContainer,
            backgroundColor: colorScheme.surfaceContainerHighest,
            labelStyle: TextStyle(
              color: isSelected
                  ? colorScheme.onPrimaryContainer
                  : colorScheme.onSurfaceVariant,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isSelected
                    ? colorScheme.primary.withValues(alpha: 0.3)
                    : Colors.transparent,
              ),
            ),
            showCheckmark: false,
          );
        },
      ),
    );
  }
}
