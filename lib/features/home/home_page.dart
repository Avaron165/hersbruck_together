import 'package:flutter/material.dart';
import '../../ui/widgets/app_scaffold.dart';
import '../../data/mock/mock_event_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final repo = MockEventRepository();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Hersbruck Together',
      body: FutureBuilder(
        future: repo.listUpcoming(),
        builder: (context, snapshot) {
          final events = snapshot.data ?? [];
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: events.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, i) {
              final e = events[i];
              return Card(
                child: ListTile(
                  title: Text(e.title),
                  subtitle: Text('${e.location} • ${e.category}'),
                  trailing: Text(
                    '${e.startsAt.hour.toString().padLeft(2, '0')}:${e.startsAt.minute.toString().padLeft(2, '0')}',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
