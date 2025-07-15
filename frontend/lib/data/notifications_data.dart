import '../models/notifications.dart';

final ongNotifications = <NotificationItem>[
  NotificationItem(
    name: 'José Roberto Souza',
    message: 'Te avaliou!',
    timestamp: DateTime.now().subtract(Duration(minutes: 10)),
    isNew: true,
  ),
  NotificationItem(
    name: 'Vitória Rocha Barbosa',
    message: 'Se inscreveu no evento Campanha de Doação',
    timestamp: DateTime.now().subtract(Duration(minutes: 25)),
    isNew: true,
  ),
  NotificationItem(
    name: 'Camila Nascimento Alves',
    message: 'Te avaliou!',
    timestamp: DateTime.now().subtract(Duration(hours: 5)),
  ),
  NotificationItem(
    name: 'Larissa Martins Ribeiro',
    message: 'Se inscreveu no evento Arrecadação de Ração',
    timestamp: DateTime.now().subtract(Duration(hours: 5)),
  ),
  NotificationItem(
    name: 'Gabriel Almeida Costa',
    message: 'Se inscreveu no evento Arrecadação de Ração',
    timestamp: DateTime.now().subtract(Duration(hours: 6)),
  ),
  NotificationItem(
    name: 'Maria Eduarda Souza',
    message: 'Te avaliou!',
    timestamp: DateTime.now().subtract(Duration(days: 3)),
  ),
  NotificationItem(
    name: 'Leonardo Rocha Barbosa',
    message: 'Participar da campanha de adoção de animais',
    timestamp: DateTime.now().subtract(Duration(days: 3)),
  ),
];

final volunteerNotifications = <NotificationItem>[
  NotificationItem(
    name: 'Vida Animal - ONG',
    message: 'Confira o novo post de Vida Animal - ONG',
    timestamp: DateTime.now().subtract(Duration(minutes: 5)),
    isNew: true,
  ),
  NotificationItem(
    name: 'Paróquia Santo Antônio',
    message: 'Confira o novo post de Paróquia Santo Antônio',
    timestamp: DateTime.now().subtract(Duration(hours: 2)),
  ),
  NotificationItem(
    name: 'Vida Animal - ONG',
    message: 'Te avaliou!',
    timestamp: DateTime.now().subtract(Duration(days: 1)),
  ),
  NotificationItem(
    name: 'Programa Amor Pet',
    message: 'Talvez você goste',
    timestamp: DateTime.now().subtract(Duration(days: 1)),
  ),
  NotificationItem(
    name: 'Paróquia Santo Antônio',
    message: 'Acabou de marcar um novo evento!',
    timestamp: DateTime.now().subtract(Duration(days: 3)),
  ),
];

// Uso no widget:
// NotificationScreen(userType: UserType.Volunteer, notifications: volunteerNotifications);
// NotificationScreen(userType: UserType.ONG,       notifications: ongNotifications);
