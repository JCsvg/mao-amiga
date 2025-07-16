import 'package:flutter/material.dart';
import '../model/event_description_model.dart';

class EventDescriptionWidget extends StatelessWidget {
  final EventDescriptionModel event;

  const EventDescriptionWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(event.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data e horário',
              style: textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            Text(event.date, style: textTheme.bodyLarge),
            Text(event.time, style: textTheme.bodyLarge),
            const SizedBox(height: 24),
            Text(
              'Descrição',
              style: textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              event.description,
              style: textTheme.bodyLarge?.copyWith(height: 1.5),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  // TODO: Adicionar lógica de inscrição
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Inscrição para "${event.title}" ainda não implementada.',
                      ),
                    ),
                  );
                },
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: textTheme.titleSmall,
                ),
                child: const Text('Quero me inscrever'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
