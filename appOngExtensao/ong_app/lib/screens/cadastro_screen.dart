import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final telefoneController = TextEditingController();
  String tipoUsuario = 'Aluna';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Usuário')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: tipoUsuario,
                decoration: InputDecoration(labelText: 'Tipo de Usuário'),
                items: ['Aluna', 'Professora']
                    .map((label) => DropdownMenuItem(
                          child: Text(label),
                          value: label,
                        ))
                    .toList(),
                onChanged: (value) => setState(() => tipoUsuario = value!),
              ),
              CustomTextField(
                controller: nomeController,
                label: 'Nome',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Digite o nome' : null,
              ),
              CustomTextField(
                controller: emailController,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Digite o email';
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Email inválido';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: telefoneController,
                label: 'Telefone',
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Digite o telefone' : null,
              ),
              SizedBox(height: 24),
              CustomButton(
                text: 'Cadastrar',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$tipoUsuario ${nomeController.text} cadastrado!'),
                      ),
                    );
                    Navigator.pushNamed(context, '/usuarios');
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
