import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class ListaUsuariosScreen extends StatelessWidget {
  final List<String> alunas = ['Maria', 'Ana', 'Jéssica'];
  final List<String> professoras = ['Luciana', 'Fernanda'];

  final List<Map<String, dynamic>> turmas = [
    {'nome': 'Turma 1', 'professora': 'Luciana', 'alunas': ['Maria', 'Ana']},
    {'nome': 'Turma 2', 'professora': 'Fernanda', 'alunas': ['Jéssica']},
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Usuários e Turmas'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Usuários'),
              Tab(text: 'Turmas'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildUsuariosTab(context),
            _buildTurmasTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildUsuariosTab(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: 'Alunas'),
                    Tab(text: 'Professoras'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildList(alunas),
                      _buildList(professoras),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                text: 'Cadastrar Usuário',
                onPressed: () => Navigator.pushNamed(context, '/cadastro'),
              ),
              CustomButton(
                text: 'Cadastrar Turma',
                onPressed: () => Navigator.pushNamed(context, '/turmas'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTurmasTab() {
    return ListView.builder(
      itemCount: turmas.length,
      itemBuilder: (context, index) {
        final turma = turmas[index];
        return Card(
          margin: EdgeInsets.all(12),
          child: ListTile(
            title: Text(turma['nome']),
            subtitle: Text('Professora: ${turma['professora']}\nAlunas: ${turma['alunas'].join(', ')}'),
            isThreeLine: true,
            trailing: Icon(Icons.group),
          ),
        );
      },
    );
  }

  Widget _buildList(List<String> nomes) {
    return ListView.builder(
      itemCount: nomes.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(nomes[index]),
          trailing: Icon(Icons.arrow_forward_ios),
        );
      },
    );
  }
}
