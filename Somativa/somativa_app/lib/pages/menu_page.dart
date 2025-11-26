import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/cart_provider.dart';
import '../models/food.dart';
import '../services/api_service.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final token = context.watch<AuthProvider>().token;

    if (token == null || token.isEmpty) {
      // Se o token for inválido ou não encontrado, mostramos a mensagem e o botão
      return Scaffold(
        appBar: AppBar(title: Text("Cardápio")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Mensagem de erro
              Text(
                "Token inválido ou não encontrado.\nFaça login novamente.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
              SizedBox(height: 20),
              // Botão de login
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/login");
                },
                child: Text("Ir para Login"),
                style: ElevatedButton.styleFrom(
                 backgroundColor: Colors.deepOrange, // Cor do botão
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Se o token estiver correto, exibe o cardápio
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cardápio",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrange,  // Cor personalizada da AppBar
        actions: [
          // Ícone do carrinho de compras
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, "/cart");
            },
          ),
          // Botão de sair (logout)
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () async {
              // Realiza o logout e navega para a tela de login
              await context.read<AuthProvider>().logout();
              Navigator.pushReplacementNamed(context, "/login");
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Food>>(
        future: ApiService().getFoods(token),
        builder: (context, snapshot) {
          // Exibe um indicador de carregamento enquanto a requisição está em andamento
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // Exibe erro se ocorrer algum problema durante a requisição
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Erro ao carregar cardápio:\n${snapshot.error}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            );
          }

          // Exibe mensagem caso não haja itens
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Nenhum item encontrado"));
          }

          final foods = snapshot.data!; // Lista de alimentos
          return ListView.builder(
            itemCount: foods.length,
            itemBuilder: (_, i) {
              final item = foods[i];
              return ListTile(
                leading: Icon(
                  Icons.fastfood,  // Ícone representativo (pode ser substituído por uma imagem)
                  color: Colors.deepOrange,
                ),
                title: Text(item.name),
                subtitle: Text("R\$ ${item.price.toStringAsFixed(2)}"),
                trailing: IconButton(
                  icon: Icon(Icons.add_circle, color: Colors.deepOrange),
                  onPressed: () => context.read<CartProvider>().add(item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
