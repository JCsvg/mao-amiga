// notifications_page.dart

import 'package:flutter/material.dart';
import '../../data/notification_data.dart';
import '../../models/notification.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<NotificationData> _notifications = [
    NotificationData(
      authorName: 'Vida Animal - ONG',
      timeAgo: 'Há 5 mins',
      caption:
          'Confira o novo post de Vida Animal - ONG\n| Mais um canil pronto para abrigar nos...',
      avatarAsset: 'assets/vida_animal_logo.png', // Exemplo de caminho do asset
      isUnread: true,
    ),
    NotificationData(
      authorName: 'Paróquia Santo Antônio',
      timeAgo: 'Há 2 hrs',
      caption:
          'Confira o novo post de Paróquia Santo A...\n| Muito obrigado a todos pela participa...',
      avatarAsset: 'assets/santo_antonio_logo.png',
      isUnread: true,
    ),
    NotificationData(
      authorName: 'Vida Animal - ONG',
      timeAgo: '1 dia atrás',
      caption: 'Te avaliou!',
      avatarAsset: 'assets/vida_animal_logo.png',
    ),
    NotificationData(
      authorName: 'Programa Amor Pet',
      timeAgo: '1 dia atrás',
      caption: 'Talvez você goste',
      avatarAsset: 'assets/amor_pet_logo.png',
    ),
    NotificationData(
      authorName: 'Paróquia Santo Antônio',
      timeAgo: '3 dias atrás',
      caption: 'Acabou de marcar um novo evento!',
      avatarAsset: 'assets/santo_antonio_logo.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          'Notificações',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return NotificationItem(notification: notification);
        },
      ),
    );
  }
}
