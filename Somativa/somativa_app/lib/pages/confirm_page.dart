import 'package:flutter/material.dart';
import '../models/food.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart'; // Importando o provider para o logout

class ConfirmPage extends StatefulWidget {
  final Map<String, dynamic>? endereco;
  final double total;
  final List<Food> itens;

  ConfirmPage({
    required this.endereco,
    required this.total,
    required this.itens,
  });

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  bool pedidoFinalizado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirmação do Pedido"),
        backgroundColor: Colors.deepOrange, // Cor da barra de app
        actions: [
          // Botão de "Sair" (logout) na AppBar
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () async {
              // Realiza o logout e navega para a tela de login
              await Provider.of<AuthProvider>(context, listen: false).logout(); // Alterei para Provider.of
              Navigator.pushReplacementNamed(context, "/login");
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Mostra o endereço
            if (widget.endereco != null)
              Text(
                "Endereço de entrega:\n${widget.endereco!["logradouro"]}, ${widget.endereco!["bairro"]}, ${widget.endereco!["localidade"]} - ${widget.endereco!["uf"]}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 20),

            // Lista de itens
            Expanded(
              child: ListView(
                children: widget.itens
                    .map((e) => ListTile(
                          title: Text(e.name),
                          subtitle: Text("R\$ ${e.price.toStringAsFixed(2)}"),
                        ))
                    .toList(),
              ),
            ),

            // Total
            SizedBox(height: 10),
            Text(
              "Total do pedido: R\$ ${widget.total.toStringAsFixed(2)}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),

            SizedBox(height: 20),

            // Botão de finalizar pedido
            ElevatedButton(
              onPressed: pedidoFinalizado
                  ? null
                  : () {
                      setState(() {
                        pedidoFinalizado = true;
                      });
                      // Aqui você pode chamar uma API para salvar o pedido
                      // Exemplo: _finalizarPedido();
                    },
              child: Text("Finalizar Pedido"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange, // Cor do botão
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            if (pedidoFinalizado)
              Column(
                children: [
                  SizedBox(height: 20),
                  Icon(Icons.check_circle, color: Colors.green, size: 60),
                  SizedBox(height: 10),
                  Text("Pedido Confirmado!", style: TextStyle(fontSize: 18)),
                  Text("Status: Em preparo", style: TextStyle(fontSize: 16)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
