import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? token;
  final String baseUrl = "http://10.0.2.2:8000";

  // Método de login
  Future<bool> login(String email, String password) async {
    final url = Uri.parse("$baseUrl/auth/login/");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      token = data['access'];
      print("TOKEN RECEBIDO: $token");

      // Salvar o token no SharedPreferences para persistência
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token!);

      return true;
    }
    print("Erro no login: ${response.body}");
    return false;
  }

  // Método de logout
  Future<void> logout() async {
    // Limpar o token da variável
    token = null;

    // Remover o token do SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    // Notificar os ouvintes que o estado mudou
    notifyListeners();
  }

  // Método para auto-login (verifica se há token salvo)
  Future<void> autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('token');
    if (savedToken != null) {
      token = savedToken;
      notifyListeners();
    }
  }
  
  // Método de registro
  Future<bool> register(String email, String password) async {
    final url = Uri.parse("$baseUrl/auth/register/");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    return response.statusCode == 201 || response.statusCode == 200;
  }
}
