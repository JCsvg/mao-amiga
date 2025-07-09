import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email;

  late String senha;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Title(color: Colors.black, child: const Text("Mão Amiga")),
          const Text("Conectando você a quem precisa de uma mãozinha", style: TextStyle(color: Colors.grey, fontSize: 12.0),),
          const Text("Crie sua conta", style: TextStyle(fontWeight: FontWeight.bold),),
          const Text("Insira seu e-mail e senha", style: TextStyle(fontWeight: FontWeight.w300),),
          
        ],
      ),
    );
  }
}

//           TextField(
//             decoration: const InputDecoration(
//               border: UnderlineInputBorder(),
//               labelText: "email@dominio.com"
//             ),
//             onChanged: (value) => email,
//           ),
//           TextField(
//             decoration: const InputDecoration(
//               border: UnderlineInputBorder(),
//               labelText: "senha123"
//             ),
//             onChanged: (value) => senha,
//           ),
//           ElevatedButton(
//             style: ButtonStyle(backgroundColor: WidgetStateColor.resolveWith((states) => Colors.black,)),
//             onPressed: () {
//               if (email != " " && senha != " ") { const Text("Tudo certo"); } 
//               else if (email == " ") { const Text("E-mail não preenchido"); } 
//               else if (senha == " ") { const Text("Senha não preenchida"); }
//               else { const Text("Dados não preenchidos"); }
//             }, 
//             child: const Text("Continuar", textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
//           )