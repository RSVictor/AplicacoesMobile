import 'dart:convert';
import 'package:http/http.dart' as http;

class ViaCepService {
  Future<Map<String, dynamic>> buscarCep(String cep) async {
    final url = Uri.parse("https://viacep.com.br/ws/$cep/json/");
    final response = await http.get(url);

    return jsonDecode(response.body);
  }
}
