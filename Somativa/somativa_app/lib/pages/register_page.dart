import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class RegisterPage extends StatelessWidget {
  final email = TextEditingController();
  final senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Criar Conta")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: email, decoration: InputDecoration(label: Text("Email"))),
            TextField(controller: senha, obscureText: true, decoration: InputDecoration(label: Text("Senha"))),
            SizedBox(height: 20),
            ElevatedButton(
  onPressed: () async {
    bool ok = await context.read<AuthProvider>().register(email.text, senha.text);
    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Cadastro realizado!")));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro ao cadastrar!")));
    }
  },
  child: Text("Cadastrar"),
),
          ],
        ),
      ),
    );
  }
}
