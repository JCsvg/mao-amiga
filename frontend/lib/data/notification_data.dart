class NotificationData {
  final String authorName;
  final String avatarAsset;
  final String timeAgo;
  final String caption;
  final bool isUnread;

  NotificationData({
    required this.authorName,
    required this.avatarAsset,
    required this.timeAgo,
    required this.caption,
    this.isUnread = false,
  });
}
