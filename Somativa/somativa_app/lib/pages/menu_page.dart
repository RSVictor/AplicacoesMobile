import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/api_service.dart';
import '../models/food.dart';
import '../providers/cart_provider.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final token = context.watch<AuthProvider>().token!;

    return Scaffold(
      appBar: AppBar(
        title: Text("Cardápio"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, "/cart"),
          )
        ],
      ),
      body: FutureBuilder<List<Food>>(
        future: ApiService().getFoods(token),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final foods = snapshot.data!;
          return ListView.builder(
            itemCount: foods.length,
            itemBuilder: (_, i) {
              final item = foods[i];
              return ListTile(
                title: Text(item.name),
                subtitle: Text("R\$ ${item.price}"),
                trailing: IconButton(
                  icon: Icon(Icons.add_circle),
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
