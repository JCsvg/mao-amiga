// Modelo de dados de notificação
class NotificationItem {
  final String name;
  final String message;
  final DateTime timestamp;
  final bool isNew;

  NotificationItem({
    required this.name,
    required this.message,
    required this.timestamp,
    this.isNew = false,
  });
}