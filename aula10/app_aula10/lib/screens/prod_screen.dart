import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Produto_screen extends StatefulWidget {
  const Produto_screen({super.key});

  @override
  State<Produto_screen> createState() => _Produto_screenState();
}

class _Produto_screenState extends State<Produto_screen> {
  // Função para carregar os dados assim que a tela for iniciada
  void initState(){
    super.initState();
    leituradados();
  }

  // Cria a variavel dado
  List dado = [];
  Future<void> leituradados()async{
    String url = "http://10.109.83.13:8000/api/produtos/";
    http.Response resposta = await http.get(Uri.parse(url));

    if(resposta.statusCode==200){
      setState(() {
        dado = jsonDecode(resposta.body) as List<dynamic>; // conversão dos produtos para uma lista
        print(dado);
      });
    }else{
      print(resposta.statusCode);
      throw Exception('Falha ao consumir API')
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('App com backend Django'),
      ),
      body: Center(
        child:  ListView.builder(
          itemCount: dado.length,
          itemBuilder: (context,index){
            final item = dado[index];
            return ListTile(
              title: Text('Nome: ${item["nome"]}',style: TextStyle(fontSize: 18),textAlign: TextAlign.center,),
              subtitle: Column(
                children: [
                  Text('Valor: R\$ ${item['preco']}',style: TextStyle(fontSize: 18),),
                  Text('Qtde: ${item['quantidade']}',style: TextStyle(fontSize: 18),),
                  Text('ID: ${item['id']}',style: TextStyle(fontSize: 18),)
                ],

              ),
              
            );

          }),
      ),
    );
  }
}