import 'package:flutter/material.dart';

class Avaliacao {
  final String nome;
  final String data;
  final double nota;
  final String? comentario;

  Avaliacao({
    required this.nome,
    required this.data,
    required this.nota,
    this.comentario,
  });
}

class AvaliacaoWidget extends StatelessWidget {
  final Avaliacao avaliacao;

  const AvaliacaoWidget({super.key, required this.avaliacao});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      avaliacao.nome,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Row(
                      children: [
                        Text(
                          avaliacao.data,
                          style:
                              const TextStyle(color: Colors.black54, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: List.generate(5, (i) {
              return Icon(
                i < avaliacao.nota ? Icons.star : Icons.star_border,
                size: 20,
                color: Colors.black,
              );
            }),
          ),
          if (avaliacao.comentario != null) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                avaliacao.comentario!,
                style: const TextStyle(fontSize: 14),
              ),
            )
          ],
        ],
      ),
    );
  }
}
