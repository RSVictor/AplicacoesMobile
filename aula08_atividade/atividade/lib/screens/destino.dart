import 'package:flutter/material.dart';
import 'checkout.dart'; 

class Destino extends StatefulWidget {
  final String nomeDestino;
  final String imagem;
  final int valord; 
  final int valorp; 

  const Destino({
    Key? key,
    required this.nomeDestino,
    required this.imagem,
    required this.valord,
    required this.valorp,
  }) : super(key: key);

  @override
  State<Destino> createState() => _DestinoState();
}

class _DestinoState extends State<Destino> {
  int nDiarias = 0;
  int nPessoas = 0;
  int total = 0;

  void dias() {
    setState(() {
      nDiarias++;
    });
  }

  void nPessoasFunc() {
    setState(() {
      nPessoas++;
    });
  }

  void limpar() {
    setState(() {
      nDiarias = 0;
      nPessoas = 0;
      total = 0;
    });
  }

  void calcularTotal() {
    if (nDiarias == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Informe o número de diárias')),
      );
      return;
    }
    // Navegar para a tela de checkout
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Checkout(
          destino: widget.nomeDestino,
          nDiarias: nDiarias,
          nPessoas: nPessoas,
          valorDiaria: widget.valord,
          valorPessoa: widget.valorp,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 393,
      height: 250,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Image.asset(
            widget.imagem,
            width: double.infinity,
            height: 120,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8),
          Text(
            widget.nomeDestino,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text('Valor diária: R\$${widget.valord}'),
          Text('Valor por pessoa: R\$${widget.valorp}'),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text('Diárias: $nDiarias'),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: dias,
                  ),
                ],
              ),
              Column(
                children: [
                  Text('Acompanhantes: $nPessoas'),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: nPessoasFunc,
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: calcularTotal,
                child: Text('Calcular Total'),
              ),
              ElevatedButton(
                onPressed: limpar,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text('Limpar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
