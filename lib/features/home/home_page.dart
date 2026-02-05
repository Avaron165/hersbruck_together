import 'package:flutter/material.dart';
import 'package:hersbruck_together/data/mock/mock_event_repository.dart';
import 'package:hersbruck_together/ui/widgets/app_scaffold.dart';

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
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final e = events[index];
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
