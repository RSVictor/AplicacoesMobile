import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.handyman, size: 100, color: Colors.pink), // ícone seguro
            SizedBox(height: 30),
            Text('Bem-vinda à ONG Costura!', style: TextStyle(fontSize: 24)),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/usuarios'); // vai direto
              },
              child: Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}
