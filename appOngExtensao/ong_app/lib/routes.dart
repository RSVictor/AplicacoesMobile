import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/cadastro_screen.dart';
import 'screens/lista_usuarios_screen.dart';
import 'screens/cadastro_turma_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => WelcomeScreen(),
  '/login': (context) => LoginScreen(),
  '/cadastro': (context) => CadastroScreen(),
  '/usuarios': (context) => ListaUsuariosScreen(),
  '/turmas': (context) => CadastroTurmaScreen(),
};
