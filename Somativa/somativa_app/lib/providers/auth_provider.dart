import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier {
  String? token;

  // URL do backend Django
  final String baseUrl = "http://10.0.2.2:8000"; // emulador Android

  // LOGIN
  Future<bool> login(String email, String password) async {
    final url = Uri.parse("$baseUrl/auth/login/");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      token = data['token'] ?? "";
      notifyListeners();
      return true;
    } else {
      print("Erro no login: ${response.body}");
      return false;
    }
  }

Future<bool> register(String email, String password) async {
  final url = Uri.parse("$baseUrl/auth/register/");

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"email": email, "password": password}),
  );

  if (response.statusCode == 201 || response.statusCode == 200) {
    return true;
  } else {
    print("Erro ao cadastrar: ${response.body}");
    return false;
  }
}
}