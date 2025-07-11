import 'package:flutter/material.dart';
import '../../data/notifications_data.dart';
import '../../models/notifications.dart';

class NotificationsPage extends StatelessWidget {
  final bool isONG;

  const NotificationsPage({
    super.key,
    required this.isONG,
  });

  List<NotificationItem> get notifications => isONG ? ongNotifications : volunteerNotifications;

  // Formata "há X min", "há Y horas" ou "há Z dias"
  String timeAgo(DateTime ts) {
    final diff = DateTime.now().difference(ts);
    if (diff.inMinutes < 60) return '${diff.inMinutes} min${diff.inMinutes > 1 ? 's' : ''} atrás';
    if (diff.inHours < 24)   return '${diff.inHours} hora${diff.inHours > 1 ? 's' : ''} atrás';
    return '${diff.inDays} dia${diff.inDays > 1 ? 's' : ''} atrás';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () { /* TODO: abrir configurações */ },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (ctx, i) {
          final item = notifications[i];
          return ListTile(
            leading: Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage( 
                    isONG ? 'assets/images/ong_logo.png'
                          : 'assets/images/volunteer_avatar.png',
                  ),
                ),
                if (item.isNew)
                  Positioned(
                    top: 0, right: 0,
                    child: Container(
                      width: 12, height: 12,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(timeAgo(item.timestamp)),
                const SizedBox(height: 4),
                Text(item.message, maxLines: 2, overflow: TextOverflow.ellipsis),
              ],
            ),
            isThreeLine: true,
            onTap: () { /* TODO: ação ao tocar */ },
          );
        },
      ),
    );
  }
}
