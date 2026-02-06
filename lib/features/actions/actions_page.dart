import 'package:flutter/material.dart';
import 'package:hersbruck_together/app/theme.dart';
import 'package:hersbruck_together/features/actions/action_detail_page.dart';
import 'package:hersbruck_together/features/actions/mock/mock_actions.dart';
import 'package:hersbruck_together/features/actions/models/action_item.dart';
import 'package:hersbruck_together/features/actions/widgets/action_card.dart';
import 'package:hersbruck_together/features/actions/widgets/action_filter_chips.dart';
import 'package:hersbruck_together/features/actions/widgets/action_sort_row.dart';
import 'package:hersbruck_together/ui/widgets/elegant_background.dart';

/// Actions page showing partner promotions and discounts
class ActionsPage extends StatefulWidget {
  const ActionsPage({super.key});

  @override
  State<ActionsPage> createState() => _ActionsPageState();
}

class _ActionsPageState extends State<ActionsPage> {
  final _actionRepository = MockActionRepository();

  List<ActionItem>? _actions;
  bool _isLoading = true;
  ActionFilter _selectedFilter = ActionFilter.alle;
  ActionSortOption _sortOption = ActionSortOption.newest;

  @override
  void initState() {
    super.initState();
    _loadActions();
  }

  Future<void> _loadActions() async {
    final actions = await _actionRepository.listAll();
    if (mounted) {
      setState(() {
        _actions = actions;
        _isLoading = false;
      });
    }
  }

  List<ActionItem> _getFilteredAndSortedActions() {
    if (_actions == null) return [];

    // Filter
    var filtered = _actions!.where((action) {
      return _selectedFilter.matches(action);
    }).toList();

    // Sort
    switch (_sortOption) {
      case ActionSortOption.newest:
        filtered.sort((a, b) {
          // New items first, then by validity date
          if (a.isNew != b.isNew) {
            return a.isNew ? -1 : 1;
          }
          return 0;
        });
        break;
      case ActionSortOption.endingSoon:
        filtered.sort((a, b) {
          // Items with end date first, sorted by closest end date
          if (a.validTo == null && b.validTo == null) return 0;
          if (a.validTo == null) return 1;
          if (b.validTo == null) return -1;
          return a.validTo!.compareTo(b.validTo!);
        });
        break;
      case ActionSortOption.alphabetical:
        filtered.sort((a, b) => a.title.compareTo(b.title));
        break;
    }

    return filtered;
  }

  void _openActionDetail(ActionItem action) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => ActionDetailPage(action: action),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElegantBackground(
      child: SafeArea(
        bottom: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: CustomScrollView(
              slivers: [
                // Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: _buildHeader(),
                  ),
                ),
                // Filter chips
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: ActionFilterChips(
                      selectedFilter: _selectedFilter,
                      onFilterSelected: (filter) {
                        setState(() {
                          _selectedFilter = filter;
                        });
                      },
                    ),
                  ),
                ),
                // Sort row
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                    child: ActionSortRow(
                      selectedOption: _sortOption,
                      onOptionSelected: (option) {
                        setState(() {
                          _sortOption = option;
                        });
                      },
                    ),
                  ),
                ),
                // Actions list
                if (_isLoading)
                  SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: goldAccent.withValues(alpha: 0.7),
                        strokeWidth: 2,
                      ),
                    ),
                  )
                else ...[
                  _buildActionsList(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.local_offer_outlined,
              size: 20,
              color: goldAccent.withValues(alpha: 0.8),
            ),
            const SizedBox(width: 8),
            const Text(
              'Aktionen',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Vorteile & Aktionen unserer Partner',
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }

  Widget _buildActionsList() {
    final actions = _getFilteredAndSortedActions();

    if (actions.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off,
                size: 56,
                color: Colors.white.withValues(alpha: 0.25),
              ),
              const SizedBox(height: 16),
              Text(
                'Keine Aktionen gefunden',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Versuchen Sie einen anderen Filter',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white.withValues(alpha: 0.3),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final action = actions[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: ActionCard(
                action: action,
                onTap: () => _openActionDetail(action),
              ),
            );
          },
          childCount: actions.length,
        ),
      ),
    );
  }
}
