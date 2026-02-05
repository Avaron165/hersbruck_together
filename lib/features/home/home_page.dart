// Hersbruck Together - Home Page UI Mockup
//
// Aufbau:
// - HomeHeader: lib/features/home/widgets/home_header.dart
//   -> Titel, Untertitel, Account-Icon, Standortchip, Suchfeld
// - CategoryChips: lib/features/home/widgets/category_chips.dart
//   -> Horizontale Filter-Chips für Kategorien
// - EventCard: lib/features/home/widgets/event_card.dart
//   -> Karten für Veranstaltungen mit Bookmark-Toggle
// - PlaceholderPage: lib/features/home/widgets/placeholder_page.dart
//   -> Platzhalter für nicht implementierte Tabs
//
// State: selectedCategory, bookmarkedIds, searchQuery, currentTabIndex

import 'package:flutter/material.dart';
import 'package:hersbruck_together/data/mock/mock_event_repository.dart';
import 'package:hersbruck_together/data/models/event.dart';
import 'package:hersbruck_together/features/home/widgets/category_chips.dart';
import 'package:hersbruck_together/features/home/widgets/event_card.dart';
import 'package:hersbruck_together/features/home/widgets/home_header.dart';
import 'package:hersbruck_together/features/home/widgets/placeholder_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _repo = MockEventRepository();

  int _currentTabIndex = 0;
  String _selectedCategory = 'Alle';
  String _searchQuery = '';
  final Set<String> _bookmarkedIds = {};

  List<Event> _filterEvents(List<Event> events) {
    return events.where((event) {
      final matchesCategory =
          _selectedCategory == 'Alle' || event.category == _selectedCategory;

      final query = _searchQuery.toLowerCase();
      final matchesSearch = query.isEmpty ||
          event.title.toLowerCase().contains(query) ||
          event.location.toLowerCase().contains(query) ||
          event.category.toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  Widget _buildTodayTab() {
    return FutureBuilder<List<Event>>(
      future: _repo.listUpcoming(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final events = _filterEvents(snapshot.data ?? []);

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: HomeHeader(
                  searchQuery: _searchQuery,
                  onSearchChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 16),
                child: CategoryChips(
                  selectedCategory: _selectedCategory,
                  onCategorySelected: (category) {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                ),
              ),
            ),
            if (events.isEmpty)
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.event_busy_outlined,
                        size: 64,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Keine Veranstaltungen gefunden',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final event = events[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: EventCard(
                          event: event,
                          isBookmarked: _bookmarkedIds.contains(event.id),
                          onBookmarkToggle: () {
                            setState(() {
                              if (_bookmarkedIds.contains(event.id)) {
                                _bookmarkedIds.remove(event.id);
                              } else {
                                _bookmarkedIds.add(event.id);
                              }
                            });
                          },
                        ),
                      );
                    },
                    childCount: events.length,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildBody() {
    switch (_currentTabIndex) {
      case 0:
        return _buildTodayTab();
      case 1:
        return const PlaceholderPage(
          title: 'Entdecken',
          icon: Icons.explore_outlined,
        );
      case 2:
        return const PlaceholderPage(
          title: 'Karte',
          icon: Icons.map_outlined,
        );
      case 3:
        return const PlaceholderPage(
          title: 'Profil',
          icon: Icons.person_outlined,
        );
      default:
        return _buildTodayTab();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: _buildBody(),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentTabIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentTabIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.today_outlined),
            selectedIcon: Icon(Icons.today),
            label: 'Heute',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Entdecken',
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map),
            label: 'Karte',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outlined),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
