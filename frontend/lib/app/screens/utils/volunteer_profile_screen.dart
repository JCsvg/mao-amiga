import 'package:flutter/material.dart';
import '../../theme_mode_app.dart';

// ignore: must_be_immutable
class VolunteerProfileScreen extends StatelessWidget {
  final ThemeModeApp themeControl;
  const VolunteerProfileScreen({super.key, required this.themeControl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Meu perfil",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [IconButton(icon: const Icon(Icons.edit), onPressed: () {})],
      ),
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
                  backgroundImage: NetworkImage(
                    'https://via.placeholder.com/150',
                  ), // troque pelo seu asset ou URL
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Gaby Trindade',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: List.generate(
                          5,
                          (i) => const Icon(
                            Icons.star,
                            size: 22,
                            color: Colors.black,
                          ),
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
                _Bullet(
                  text: 'Distribuição de Alimento em Paróquia Santo Antônio',
                ),
                _Bullet(text: 'Campanha de Adoção em Vida Animal – ONG'),
              ],
            ),

            const SizedBox(height: 32),
            // Configurações
            Row(
              children: [
                Icon(Icons.list),
                Padding(padding: EdgeInsetsGeometry.only(right: 15)),
                Text("Histórico completo"),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.group_add_outlined),
                Padding(padding: EdgeInsetsGeometry.only(right: 15)),
                Text("Gerenciar inscrições"),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.event),
                Padding(padding: EdgeInsetsGeometry.only(right: 15)),
                Text("Gerenciar eventos"),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.error),
                Padding(padding: EdgeInsetsGeometry.only(right: 15)),
                Text("Reportar problemas"),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Modo escuro"),
                Switch(
                  value: themeControl.isDarkMode,

                  onChanged: (novoValor) {
                    themeControl.alterarTema(novoValor);
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextButton(onPressed: () {}, child: Text("Sair")),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.handshake, color: Colors.grey, size: 18.0),
                Padding(padding: EdgeInsetsGeometry.only(right: 15)),
                Text(
                  "Ajude os desenvolvedores",
                  style: TextStyle(color: Colors.grey, fontSize: 12.0),
                ),
              ],
            ),
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
