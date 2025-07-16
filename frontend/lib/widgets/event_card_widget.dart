import 'package:flutter/material.dart';
import '../app/screens/utils/avaliable_volunteer_screen.dart';
import '../model/event_description_model.dart';
import './event_description_widget.dart';

class EventCardWidget extends StatelessWidget {
  final EventDescriptionModel event;
  final bool isOng;

  const EventCardWidget({super.key, required this.event, required this.isOng});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return GestureDetector(
      onTap: () {
        if (isOng) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => _RegisteredVolunteersScreen(event: event),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventDescriptionWidget(event: event),
            ),
          );
        }
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.colorScheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.date,
                  style: textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(event.time, style: textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              event.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RegisteredVolunteersScreen extends StatelessWidget {
  final EventDescriptionModel event;

  const _RegisteredVolunteersScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inscritos em "${event.title}"')),
      body: ListView(
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=gaby'),
            ),
            title: const Text('Gaby Trindade'),
            subtitle: const Text('Inscrição confirmada'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const AvailableVolunteerScreen(isOng: false),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
