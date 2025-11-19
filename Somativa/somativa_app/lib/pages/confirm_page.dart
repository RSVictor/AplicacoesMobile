import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class ConfirmPage extends StatelessWidget {
  final Map<String, dynamic>? endereco;

  ConfirmPage({required this.endereco});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final taxa = cart.total < 100 ? 8.0 : 0.0;

    return Scaffold(
      appBar: AppBar(title: Text("Confirmar Pedido")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Endereço de entrega:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("${endereco!['logradouro']} - ${endereco!['bairro']}"),
            SizedBox(height: 20),
            Text("Total final: R\$ ${(cart.total + taxa).toStringAsFixed(2)}"),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Enviar Pedido"),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Pedido enviado com sucesso!")),
                );
                cart.clear();
                Navigator.popUntil(context, ModalRoute.withName("/menu"));
              },
            )
          ],
        ),
      ),
    );
  }
}
