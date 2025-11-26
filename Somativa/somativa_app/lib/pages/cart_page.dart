import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../services/viacep_service.dart';
import 'confirm_page.dart';
import '../providers/auth_provider.dart'; 
class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cepController = TextEditingController();
  Map<String, dynamic>? endereco;
  bool carregandoCep = false;

  double calcularTaxa(double total) => total < 100 ? 8.0 : 0.0;

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final taxa = calcularTaxa(cart.total);

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: Text("Carrinho de Compras"),
        backgroundColor: Colors.deepOrange,
        actions: [
          // Botão de "Sair" (logout) na AppBar
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Lista de itens do carrinho
            Expanded(
              child: ListView(
                children: cart.items
                    .map((e) => Card(
                          margin: EdgeInsets.symmetric(vertical: 6),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 3,
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            title: Text(
                              e.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("R\$ ${e.price.toStringAsFixed(2)}"),
                            trailing: IconButton(
                              icon: Icon(Icons.remove_circle, color: Colors.red),
                              onPressed: () => cart.remove(e),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),

            // Campo CEP
            TextField(
              controller: cepController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Digite seu CEP",
                labelStyle: TextStyle(color: Colors.deepOrange),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  color: Colors.deepOrange,
                  onPressed: () async {
                    setState(() => carregandoCep = true);
                    endereco = await ViaCepService().buscarCep(cepController.text);
                    setState(() => carregandoCep = false);
                  },
                ),
              ),
            ),

            // Exibe o loading enquanto busca o CEP
            if (carregandoCep)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: CircularProgressIndicator(color: Colors.deepOrange),
              ),

            // Mostra o endereço se encontrado
            if (endereco != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "Endereço: ${endereco!["logradouro"]}, ${endereco!["bairro"]}, ${endereco!["localidade"]} - ${endereco!["uf"]}",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),

            SizedBox(height: 10),

            // Exibe a taxa de entrega e o total
            Text("Taxa de entrega: R\$ ${taxa.toStringAsFixed(2)}"),
            Text(
              "Total: R\$ ${(cart.total + taxa).toStringAsFixed(2)}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),

            SizedBox(height: 10),

            // Botão de confirmar pedido
            ElevatedButton(
              onPressed: endereco != null && cart.items.isNotEmpty
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ConfirmPage(
                            endereco: endereco,
                            total: cart.total + taxa,
                            itens: cart.items,
                          ),
                        ),
                      );
                    }
                  : null,
              child: Text("Confirmar Pedido"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange, // Cor de fundo do botão
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
