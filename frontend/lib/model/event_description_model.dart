class EventDescriptionModel {
  final String title;
  final String date;
  final String time;
  final String description;
  final String organizer;

  EventDescriptionModel({
    required this.title,
    required this.date,
    required this.time,
    required this.description,
    required this.organizer,
  });

  factory EventDescriptionModel.fromJson(Map<String, dynamic> json) {
    return EventDescriptionModel(
      title: json['title'] ?? 'Título indisponível',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      description: json['description'] ?? 'Descrição não fornecida.',
      organizer: json['organizer'] ?? 'Organizador desconhecido',
    );
  }
}
