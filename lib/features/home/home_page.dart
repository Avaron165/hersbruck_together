// Hersbruck Together - Home Page UI Mockup (Dark + Gold + Elegant)
//
// Aufbau:
// - ElegantBackground: lib/ui/widgets/elegant_background.dart
//   -> Subtiler dunkler Gradient mit dezenter Gold-Vignette
// - HomeHeader: lib/features/home/widgets/home_header.dart
//   -> Titel "Events", Segmented Tabs, Searchbar mit Filter
// - CategoryChips: lib/features/home/widgets/category_chips.dart
//   -> Horizontale Filter-Chips für Kategorien
// - EventCard: lib/features/home/widgets/event_card.dart
//   -> Karten mit Bild-Thumbnail links
// - PlaceholderPage: lib/features/home/widgets/placeholder_page.dart
//   -> Platzhalter für nicht implementierte Tabs
//
// State: selectedCategory, searchQuery, currentTabIndex, timeFilter

import 'package:flutter/material.dart';
import 'package:hersbruck_together/app/theme.dart';
import 'package:hersbruck_together/data/mock/mock_event_repository.dart';
import 'package:hersbruck_together/data/models/event.dart';
import 'package:hersbruck_together/features/home/widgets/category_chips.dart';
import 'package:hersbruck_together/features/home/widgets/event_card.dart';
import 'package:hersbruck_together/features/home/widgets/home_header.dart';
import 'package:hersbruck_together/features/home/widgets/placeholder_page.dart';
import 'package:hersbruck_together/ui/widgets/elegant_background.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _repo = MockEventRepository();
  late final TextEditingController _searchController;

  int _currentTabIndex = 0;
  String _selectedCategory = 'Alle';
  String _searchQuery = '';
  TimeFilter _timeFilter = TimeFilter.heute;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  List<Event> _filterEvents(List<Event> events) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return events.where((event) {
      final matchesCategory =
          _selectedCategory == 'Alle' || event.category == _selectedCategory;

      final query = _searchQuery.toLowerCase();
      final matchesSearch = query.isEmpty ||
          event.title.toLowerCase().contains(query) ||
          event.location.toLowerCase().contains(query) ||
          event.category.toLowerCase().contains(query);

      final eventDate = DateTime(
        event.startsAt.year,
        event.startsAt.month,
        event.startsAt.day,
      );

      bool matchesTime;
      switch (_timeFilter) {
        case TimeFilter.heute:
          matchesTime = eventDate == today;
          break;
        case TimeFilter.wochenende:
          final saturday =
              today.add(Duration(days: DateTime.saturday - today.weekday));
          final sunday = saturday.add(const Duration(days: 1));
          matchesTime = eventDate == saturday ||
              eventDate == sunday ||
              (eventDate.isAfter(today) &&
                  eventDate.isBefore(sunday.add(const Duration(days: 1))));
          break;
        case TimeFilter.siebenTage:
          final endDate = today.add(const Duration(days: 7));
          matchesTime = !eventDate.isBefore(today) &&
              eventDate.isBefore(endDate.add(const Duration(days: 1)));
          break;
      }

      return matchesCategory && matchesSearch && matchesTime;
    }).toList();
  }

  Widget _buildHomeTab() {
    return FutureBuilder<List<Event>>(
      future: _repo.listUpcoming(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: goldAccent.withValues(alpha: 0.7),
              strokeWidth: 2,
            ),
          );
        }

        final events = _filterEvents(snapshot.data ?? []);

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: HomeHeader(
                  searchController: _searchController,
                  selectedTimeFilter: _timeFilter,
                  onTimeFilterChanged: (filter) {
                    setState(() {
                      _timeFilter = filter;
                    });
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 0, 12),
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
                        size: 56,
                        color: Colors.white.withValues(alpha: 0.25),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Keine Events gefunden',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 100),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final event = events[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: EventCard(event: event),
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
        return _buildHomeTab();
      case 1:
        return const PlaceholderPage(
          title: 'Karte',
          icon: Icons.map_outlined,
        );
      case 2:
        return const PlaceholderPage(
          title: 'News',
          icon: Icons.newspaper_outlined,
        );
      case 3:
        return const PlaceholderPage(
          title: 'Spenden',
          icon: Icons.favorite_outline,
        );
      default:
        return _buildHomeTab();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: ElegantBackground(
        child: SafeArea(
          bottom: false,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: _buildBody(),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0E).withValues(alpha: 0.95),
          border: Border(
            top: BorderSide(
              color: Colors.white.withValues(alpha: 0.06),
              width: 1,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: _currentTabIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentTabIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.location_on_outlined),
              selectedIcon: Icon(Icons.location_on),
              label: 'Karte',
            ),
            NavigationDestination(
              icon: Icon(Icons.newspaper_outlined),
              selectedIcon: Icon(Icons.newspaper),
              label: 'News',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_outline),
              selectedIcon: Icon(Icons.favorite),
              label: 'Spenden',
            ),
          ],
        ),
      ),
    );
  }
}
