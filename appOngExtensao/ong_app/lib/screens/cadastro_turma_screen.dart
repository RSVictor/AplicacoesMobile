import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class CadastroTurmaScreen extends StatefulWidget {
  @override
  _CadastroTurmaScreenState createState() => _CadastroTurmaScreenState();
}

class _CadastroTurmaScreenState extends State<CadastroTurmaScreen> {
  final _formKey = GlobalKey<FormState>();
  final nomeTurmaController = TextEditingController();
  String? professoraSelecionada;
  final List<String> professoras = ['Luciana', 'Fernanda'];
  final List<String> alunas = ['Maria', 'Ana', 'Jéssica'];
  final Set<String> alunasSelecionadas = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Turma')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextField(
                controller: nomeTurmaController,
                label: 'Nome da Turma',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Digite o nome da turma' : null,
              ),
              DropdownButtonFormField<String>(
                value: professoraSelecionada,
                decoration: InputDecoration(labelText: 'Professora'),
                items: professoras
                    .map((prof) => DropdownMenuItem(
                          value: prof,
                          child: Text(prof),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => professoraSelecionada = val),
                validator: (value) =>
                    value == null ? 'Selecione uma professora' : null,
              ),
              SizedBox(height: 20),
              Text(
                'Selecionar Alunas',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...alunas.map((aluna) {
                return CheckboxListTile(
                  title: Text(aluna),
                  value: alunasSelecionadas.contains(aluna),
                  onChanged: (bool? value) {
                    setState(() {
                      value! ? alunasSelecionadas.add(aluna) : alunasSelecionadas.remove(aluna);
                    });
                  },
                );
              }).toList(),
              SizedBox(height: 24),
              CustomButton(
                text: 'Salvar Turma',
                onPressed: () {
                  if (_formKey.currentState!.validate() && alunasSelecionadas.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Turma ${nomeTurmaController.text} cadastrada com ${alunasSelecionadas.length} alunas!',
                        ),
                      ),
                    );
                    Navigator.pushNamed(context, '/usuarios');
                  } else if (alunasSelecionadas.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Selecione pelo menos uma aluna')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
