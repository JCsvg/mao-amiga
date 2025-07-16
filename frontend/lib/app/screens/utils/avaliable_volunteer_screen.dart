import 'package:flutter/material.dart';

class AvailableVolunteerScreen extends StatelessWidget {
  const AvailableVolunteerScreen({super.key, required bool isOng});

  @override
  Widget build(BuildContext context) {
    // Pega as referências do tema para usar no widget.
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        // O título agora é dinâmico, representando o perfil visitado.
        title: const Text("Perfil do Voluntário"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto, nome e avaliação
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/150?u=gaby', // Usando uma URL de placeholder
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gaby Trindade',
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: List.generate(
                          5,
                          (i) => Icon(
                            // Simula uma nota 4.5
                            i < 4 ? Icons.star : Icons.star_half,
                            size: 22,
                            // Usa a cor primária do tema para as estrelas.
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      FilledButton.tonalIcon(
                        onPressed: () {
                          // TODO: Adicionar lógica para abrir tela de avaliação.
                        },
                        icon: const Icon(Icons.rate_review_outlined, size: 18),
                        label: const Text('Avaliar'),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
            // "Um pouco sobre mim"
            Text('Um pouco sobre mim', style: textTheme.titleSmall),
            const SizedBox(height: 8),
            Text(
              'Tenho 25 anos, formada em Design Gráfico e atualmente fazendo faculdade de Psicologia. '
              'Tenho um amor enorme por animais e estou pronta para ajudá-los o máximo possível. '
              'Também espero fazer parte de projetos de assistência a crianças e de distribuição de alimentos.',
              style: textTheme.bodyLarge?.copyWith(height: 1.4),
            ),

            const SizedBox(height: 24),

            // Áreas de interesse
            Text('Minhas áreas de interesse', style: textTheme.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildInterestChip(context, '#Animais'),
                _buildInterestChip(context, '#Crianças'),
                _buildInterestChip(context, '#Alimentação'),
                _buildInterestChip(context, '#Saúde'),
              ],
            ),

            const SizedBox(height: 24),

            // Histórico recente
            Text('Histórico recente', style: textTheme.titleSmall),
            const SizedBox(height: 8),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Bullet(
                  text: 'Distribuição de Alimento em Paróquia Santo Antônio',
                ),
                _Bullet(text: 'Campanha de Adoção em Vida Animal – ONG'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Chip de interesse agora usa o tema.
  Widget _buildInterestChip(BuildContext context, String label) {
    final theme = Theme.of(context);
    return Chip(
      label: Text(label),
      backgroundColor: theme.colorScheme.secondaryContainer,
      labelStyle: TextStyle(color: theme.colorScheme.onSecondaryContainer),
      shape: const StadiumBorder(),
    );
  }
}

// Widget auxiliar para bullets, agora usando o tema.
class _Bullet extends StatelessWidget {
  final String text;
  const _Bullet({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('•  ', style: Theme.of(context).textTheme.bodyLarge),
          Expanded(
            child: Text(
              text,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
