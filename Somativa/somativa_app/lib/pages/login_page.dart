import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginPage extends StatelessWidget {
  final email = TextEditingController();
  final senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("PedeEntregue", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              TextField(controller: email, decoration: InputDecoration(label: Text("Email"))),
              TextField(controller: senha, obscureText: true, decoration: InputDecoration(label: Text("Senha"))),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("Entrar"),
                onPressed: () async {
                  bool ok = await context.read<AuthProvider>().login(email.text, senha.text);
                  if (ok) Navigator.pushReplacementNamed(context, "/menu");
                },
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, "/register"),
                child: Text("Criar conta"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
