import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../services/viacep_service.dart';
import 'confirm_page.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cep = TextEditingController();
  Map<String, dynamic>? endereco;

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final taxa = cart.total < 100 ? 8.0 : 0.0;

    return Scaffold(
      appBar: AppBar(title: Text("Carrinho")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: cart.items.map((e) => ListTile(
                  title: Text(e.name),
                  subtitle: Text("R\$ ${e.price}"),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () => cart.remove(e),
                  ),
                )).toList(),
              ),
            ),
            TextField(
              controller: cep,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(label: Text("CEP")),
              onSubmitted: (value) async {
                endereco = await ViaCepService().buscarCep(value);
                setState(() {});
              },
            ),
            if (endereco != null) Text("Endereço: ${endereco!["logradouro"]}"),
            SizedBox(height: 10),
            Text("Taxa: R\$ $taxa"),
            Text("Total: R\$ ${(cart.total + taxa).toStringAsFixed(2)}"),
            ElevatedButton(
              child: Text("Confirmar"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ConfirmPage(endereco: endereco)),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
