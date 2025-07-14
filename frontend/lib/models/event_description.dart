import 'package:flutter/material.dart';

class EventDescription extends StatelessWidget{
  const EventDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Arrecadação de ração"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data e horário',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              '15 de dezembro de 2025',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              'Das 14h às 18h',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              'Descrição',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              '''A ONG Vida Animal convida toda a comunidade para participar do nosso evento especial de arrecadação de ração, dedicado aos cães e gatos resgatados das ruas. 
Atualmente, acolhemos mais de 120 animais em situação de vulnerabilidade, oferecendo abrigo, cuidados veterinários e, principalmente, amor. Para continuarmos com esse trabalho essencial, precisamos da sua ajuda.
Durante o evento, estaremos recebendo doações de ração seca e úmida para cães e gatos de todas as idades. Também aceitaremos sachês, petiscos e até medicamentos básicos para uso veterinário. Além disso, haverá atividades informativas sobre adoção responsável, cuidados com animais abandonados e o impacto das doações no dia a dia da ONG.''',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {},
              child: Text('Inscrever-se'),
            )
          ],
        ),
      ), 
    );
  }
}