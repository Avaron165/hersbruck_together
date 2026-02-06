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
// - SponsoredCard: lib/features/home/widgets/sponsored_card.dart
//   -> Dezente Partner-Werbung nach dem 2. Event
// - EventDetailPage: lib/features/home/event_detail_page.dart
//   -> Detailseite für Events
// - PlaceholderPage: lib/features/home/widgets/placeholder_page.dart
//   -> Platzhalter für nicht implementierte Tabs
//
// State: selectedCategory, searchQuery, currentTabIndex, timeFilter

import 'package:flutter/material.dart';
import 'package:hersbruck_together/app/theme.dart';
import 'package:hersbruck_together/data/mock/mock_ad_repository.dart';
import 'package:hersbruck_together/data/mock/mock_event_repository.dart';
import 'package:hersbruck_together/data/models/ad.dart';
import 'package:hersbruck_together/data/models/event.dart';
import 'package:hersbruck_together/features/donation/donation_page.dart';
import 'package:hersbruck_together/features/home/event_detail_page.dart';
import 'package:hersbruck_together/features/home/widgets/category_chips.dart';
import 'package:hersbruck_together/features/home/widgets/event_card.dart';
import 'package:hersbruck_together/features/home/widgets/home_header.dart';
import 'package:hersbruck_together/features/home/widgets/placeholder_page.dart';
import 'package:hersbruck_together/features/home/widgets/sponsored_card.dart';
import 'package:hersbruck_together/ui/widgets/elegant_background.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _eventRepo = MockEventRepository();
  final _adRepo = MockAdRepository();
  late final TextEditingController _searchController;

  int _currentTabIndex = 0;
  String _selectedCategory = 'Alle';
  String _searchQuery = '';
  TimeFilter _timeFilter = TimeFilter.heute;

  List<Event>? _events;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchChanged);
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final events = await _eventRepo.listUpcoming();
    if (mounted) {
      setState(() {
        _events = events;
        _isLoading = false;
      });
    }
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

  void _openEventDetail(Event event) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => EventDetailPage(event: event),
      ),
    );
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

  List<Widget> _buildListItems(List<Event> events, Ad? sponsoredAd) {
    final items = <Widget>[];
    const adPosition = 2;

    for (int i = 0; i < events.length; i++) {
      if (i == adPosition && sponsoredAd != null) {
        items.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SponsoredCard(
              ad: sponsoredAd,
              onTap: () {},
              onCta: () {},
            ),
          ),
        );
      }
      final event = events[i];
      items.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: EventCard(
            event: event,
            onTap: () => _openEventDetail(event),
          ),
        ),
      );
    }

    if (events.length <= adPosition && sponsoredAd != null && events.isNotEmpty) {
      items.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: SponsoredCard(
            ad: sponsoredAd,
            onTap: () {},
            onCta: () {},
          ),
        ),
      );
    }

    return items;
  }

  Widget _buildHomeTab() {
    final events = _isLoading ? <Event>[] : _filterEvents(_events ?? []);
    final sponsoredAd = _adRepo.getSponsoredAd();
    final listItems = _buildListItems(events, sponsoredAd);

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
        if (_isLoading)
          SliverFillRemaining(
            child: Center(
              child: CircularProgressIndicator(
                color: goldAccent.withValues(alpha: 0.7),
                strokeWidth: 2,
              ),
            ),
          )
        else if (events.isEmpty)
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
                (context, index) => listItems[index],
                childCount: listItems.length,
              ),
            ),
          ),
      ],
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
      default:
        return _buildHomeTab();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Spenden tab uses its own page layout
    final bool isDonationTab = _currentTabIndex == 3;

    return Scaffold(
      extendBody: true,
      body: isDonationTab
          ? const DonationPage()
          : ElegantBackground(
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
