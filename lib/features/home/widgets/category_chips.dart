import 'dart:ui';
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
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;

          return GestureDetector(
            onTap: () => onCategorySelected(category),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.2)
                        : Colors.white.withValues(alpha: 0.08),
                    border: Border.all(
                      color: isSelected
                          ? goldAccent.withValues(alpha: 0.5)
                          : Colors.white.withValues(alpha: 0.15),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontSize: 14,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
