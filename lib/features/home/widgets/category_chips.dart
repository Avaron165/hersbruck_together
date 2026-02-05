import 'package:flutter/material.dart';
import 'package:hersbruck_together/app/theme.dart';

class CategoryChips extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  static const List<String> categories = [
    'Alle',
    'Feste',
    'Familie',
    'Kultur',
    'Freizeit',
  ];

  const CategoryChips({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;

          return GestureDetector(
            onTap: () => onCategorySelected(category),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.12)
                    : Colors.white.withValues(alpha: 0.04),
                border: Border.all(
                  color: isSelected
                      ? goldAccent.withValues(alpha: 0.4)
                      : Colors.white.withValues(alpha: 0.08),
                  width: 1,
                ),
              ),
              child: Text(
                category,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.6),
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
