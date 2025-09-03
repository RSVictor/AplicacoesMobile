import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
                controller: senhaController,
                label: 'Senha',
                obscureText: true,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Digite a senha' : null,
              ),
              SizedBox(height: 20),
              CustomButton(
                text: 'Entrar',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
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
