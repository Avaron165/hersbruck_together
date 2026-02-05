import 'package:flutter/material.dart';
import 'package:hersbruck_together/app/theme.dart';

enum TimeFilter { heute, wochenende, siebenTage }

class HomeHeader extends StatelessWidget {
  final TextEditingController searchController;
  final TimeFilter selectedTimeFilter;
  final ValueChanged<TimeFilter> onTimeFilterChanged;

  const HomeHeader({
    super.key,
    required this.searchController,
    required this.selectedTimeFilter,
    required this.onTimeFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Events',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),
        _buildTimeFilterTabs(),
        const SizedBox(height: 14),
        _buildSearchBar(),
      ],
    );
  }

  Widget _buildTimeFilterTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          _buildTabItem('Heute', TimeFilter.heute),
          _buildTabItem('Wochenende', TimeFilter.wochenende),
          _buildTabItem('7 Tage', TimeFilter.siebenTage),
        ],
      ),
    );
  }

  Widget _buildTabItem(String label, TimeFilter filter) {
    final isSelected = selectedTimeFilter == filter;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTimeFilterChanged(filter),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.transparent,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white54,
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                hintText: 'Nach Events suchen...',
                hintStyle: TextStyle(
                  color: Colors.white.withValues(alpha: 0.4),
                  fontSize: 14,
                ),
                prefixIcon: Icon(
                  Icons.search,
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
          Container(
            margin: const EdgeInsets.only(right: 6),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.white.withValues(alpha: 0.05),
              ),
              child: Text(
                'Filter',
                style: TextStyle(
                  color: goldAccent.withValues(alpha: 0.9),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
