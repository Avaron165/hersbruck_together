import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hersbruck_together/app/theme.dart';

enum TimeFilter { heute, wochenende, siebenTage }

class HomeHeader extends StatelessWidget {
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final TimeFilter selectedTimeFilter;
  final ValueChanged<TimeFilter> onTimeFilterChanged;

  const HomeHeader({
    super.key,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.selectedTimeFilter,
    required this.onTimeFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Events',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white70,
                size: 26,
              ),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildTimeFilterTabs(),
        const SizedBox(height: 16),
        _buildSearchBar(),
      ],
    );
  }

  Widget _buildTimeFilterTabs() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white.withValues(alpha: 0.08),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.12),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              _buildTabItem('Heute', TimeFilter.heute),
              _buildTabItem('Wochenende', TimeFilter.wochenende),
              _buildTabItem('7 Tage', TimeFilter.siebenTage, showDropdown: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem(String label, TimeFilter filter,
      {bool showDropdown = false}) {
    final isSelected = selectedTimeFilter == filter;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTimeFilterChanged(filter),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: isSelected
                ? Colors.white.withValues(alpha: 0.15)
                : Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white60,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              if (showDropdown) ...[
                const SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 18,
                  color: isSelected ? Colors.white : Colors.white60,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white.withValues(alpha: 0.08),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.12),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: onSearchChanged,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Nach Events suchen...',
                    hintStyle: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 14,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white.withValues(alpha: 0.5),
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
              Container(
                margin: const EdgeInsets.only(right: 6),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.white.withValues(alpha: 0.08),
                  ),
                  child: Text(
                    'Filter',
                    style: TextStyle(
                      color: goldLight,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
