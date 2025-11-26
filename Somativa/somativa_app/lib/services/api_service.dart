import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/food.dart';

class ApiService {
  final String baseUrl = "http://10.0.2.2:8000";

  Future<List<Food>> getFoods(String token) async {
    final url = Uri.parse("$baseUrl/foods/");
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token", // JWT correto
      },
    );

    print("GET FOODS STATUS: ${response.statusCode}");
    print("GET FOODS BODY: ${response.body}");

    if (response.statusCode != 200) {
      throw Exception("Erro ao buscar cardápio: ${response.body}");
    }

    final List data = jsonDecode(response.body);
    return data.map((item) => Food.fromJson(item)).toList();
  }
}
