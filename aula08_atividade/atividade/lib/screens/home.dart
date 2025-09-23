import 'package:flutter/material.dart';
import 'destino.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final destinos = [
      {
        "nome": "Angra dos Reis",
        "imagem": "assets/images/angra.jpg",
        "valord": 384,
        "valorp": 70,
      },
      {
        "nome": "Jericoacoara",
        "imagem": "assets/images/jericoacoara.jpg",
        "valord": 571,
        "valorp": 75,
      },
      {
        "nome": "Arraial do Cabo",
        "imagem": "assets/images/arraial_do_Cabo.jpg",
        "valord": 534,
        "valorp": 65,
      },
      {
        "nome": "Florianópolis",
        "imagem": "assets/images/florianópolis.jpg",
        "valord": 348,
        "valorp": 85,
      },
      {
        "nome": "Madri",
        "imagem": "assets/images/madri.jpg",
        "valord": 401,
        "valorp": 85,
      },
      {
        "nome": "Paris",
        "imagem": "assets/images/paris.jpg",
        "valord": 546,
        "valorp": 95,
      },
      {
        "nome": "Orlando",
        "imagem": "assets/images/orlando.jpg",
        "valord": 616,
        "valorp": 105,
      },
      {
        "nome": "Las Vegas",
        "imagem": "assets/images/las_vegas.jpg",
        "valord": 504,
        "valorp": 110,
      },
      {
        "nome": "Roma",
        "imagem": "assets/images/roma.jpg",
        "valord": 478,
        "valorp": 85,
      },
      {
        "nome": "Chile",
        "imagem": "assets/images/chile.jpg",
        "valord": 446,
        "valorp": 95,
      },

   
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('S&M Hotel'),
      ),
      body: ListView.builder(
        itemCount: destinos.length,
        itemBuilder: (context, index) {
          final d = destinos[index];
          return Destino(
            nomeDestino: d["nome"]!,
            imagem: d["imagem"]!,
            valord: d["valord"]!,
            valorp: d["valorp"]!,
          );
        },
      ),
    );
  }
}
