import 'package:flutter/material.dart';
import '../data/notification_data.dart';

class NotificationItem extends StatelessWidget {
  final NotificationData notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage(notification.avatarAsset),
                backgroundColor: Colors.grey.shade200,
              ),
              if (notification.isUnread)
                Positioned(
                  left: -16,
                  top: 20,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nome do autor e tempo
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: '${notification.authorName} ',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: notification.timeAgo,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                // Texto da notificação
                Text(
                  notification.caption,
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 15,
                    height: 1.3, // Espaçamento entre linhas
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
