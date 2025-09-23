import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Para lidar com o JSON

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = "";

  // Função para fazer o login
  Future<void> _login() async {
    setState(() {
      _isLoading = true; // Exibe o indicador de carregamento
      _errorMessage = ""; // Limpa mensagens de erro anteriores
    });

    final String username = _usernameController.text;
    final String password = _passwordController.text;

    // Verifica se os campos não estão vazios
    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Por favor, preencha todos os campos!";
      });
      return;
    }

    try {
      // URL do JSON Server - ajuste conforme sua configuração
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/usuario/login')
, // Altere para o seu endpoint
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Login bem-sucedido
        // Redireciona para a Home ou outro destino
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Se não for 200, exibe uma mensagem de erro
        setState(() {
          _isLoading = false;
          _errorMessage = "Usuário ou senha inválidos.";
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Erro ao conectar com o servidor.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Usuário',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            if (_isLoading)
              CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: _login,
                child: Text('Entrar'),
              ),
            SizedBox(height: 16),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
