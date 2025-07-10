import 'package:flutter/material.dart';

class OngVolPage extends StatelessWidget {
  const OngVolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto, nome e avaliação
            Row(
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage('https://via.placeholder.com/150'), // troque pelo seu asset ou URL
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Gaby Trindade',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: List.generate(5, (i) => const Icon(
                          Icons.star,
                          size: 18,
                          color: Colors.black,
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                          // ação de avaliar
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 3.0,
                            minimumSize: Size(150.0, 40),
                            foregroundColor: Colors.black, 
                            backgroundColor: Colors.grey[300],
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                            ),
                          child: const Text('Avaliar', style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            // "Um pouco sobre mim"
            Text(
              'Um pouco sobre mim',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tenho 25 anos, formada em Design Gráfico e atualmente fazendo faculdade de Psicologia. '
              'Tenho um amor enorme por animais e estou pronta para ajudá-los o máximo possível. '
              'Também espero fazer parte de projetos de assistência a crianças e de distribuição de alimentos.',
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            
            const SizedBox(height: 24),
            
            // Áreas de interesse
            Text(
              'Minhas áreas de interesse',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildInterestChip('#Animais'),
                _buildInterestChip('#Crianças'),
                _buildInterestChip('#Alimentação'),
                _buildInterestChip('#Saúde'),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Histórico recente
            Text(
              'Histórico recente',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Bullet(text: 'Distribuição de Alimento em Paróquia Santo Antônio'),
                _Bullet(text: 'Campanha de Adoção em Vida Animal – ONG'),
              ],
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // Chip de interesse
  Widget _buildInterestChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.grey[200],
      labelStyle: TextStyle(color: Colors.grey[700]),
      shape: const StadiumBorder(),
    );
  }
}

// Widget auxiliar para bullets
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
          const Text('•  ', style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
