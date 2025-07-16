import 'package:flutter/material.dart';
import '../model/avaliacao_model.dart';

class AvaliacaoWidget extends StatelessWidget {
  final AvaliacaoModel avaliacao;

  const AvaliacaoWidget({super.key, required this.avaliacao});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: theme.colorScheme.secondaryContainer,
                child: Icon(
                  Icons.person,
                  color: theme.colorScheme.onSecondaryContainer,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      avaliacao.nome,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(avaliacao.data, style: textTheme.bodySmall),
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
                color: theme.colorScheme.primary,
              );
            }),
          ),
          if (avaliacao.comentario != null) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(avaliacao.comentario!, style: textTheme.bodyMedium),
            ),
          ],
        ],
      ),
    );
  }
}
