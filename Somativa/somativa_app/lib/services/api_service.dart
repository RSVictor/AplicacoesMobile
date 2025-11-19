import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/food.dart';

class ApiService {
  final baseUrl = "http://192.168.0.10:8000"; // ALTERE AQUI

  // ---- LOGIN ----
  Future<String?> login(String email, String senha) async {
    final url = Uri.parse("$baseUrl/auth/login/");
    final response = await http.post(
      url,
      body: {"email": email, "password": senha},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json["access"];
    }
    return null;
  }

  // ---- CADASTRO ----
  Future<bool> register(String email, String senha) async {
    final url = Uri.parse("$baseUrl/auth/register/");
    final response = await http.post(
      url,
      body: {
        "email": email,
        "password": senha,
        "username": email,
      },
    );
    return response.statusCode == 201;
  }

  // ---- CARDÁPIO ----
  Future<List<Food>> getFoods(String token) async {
    final url = Uri.parse("$baseUrl/foods/");
    final response = await http.get(url, headers: {
      "Authorization": "Bearer $token",
    });

    final data = jsonDecode(response.body);

    return data.map<Food>((item) => Food.fromJson(item)).toList();
  }
}
