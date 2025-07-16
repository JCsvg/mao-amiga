class AvaliacaoModel {
  final String nome;
  final String data;
  final double nota;
  final String? comentario;

  AvaliacaoModel({
    required this.nome,
    required this.data,
    required this.nota,
    this.comentario,
  });

  factory AvaliacaoModel.fromJson(Map<String, dynamic> json) {
    return AvaliacaoModel(
      nome: json['nome'] ?? 'Anônimo',
      data: json['data'] ?? '',
      nota: (json['nota'] as num?)?.toDouble() ?? 0.0,
      comentario: json['comentario'],
    );
  }
}
