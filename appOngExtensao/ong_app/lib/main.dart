import 'package:flutter/material.dart';
import 'routes.dart';
import 'theme.dart';

void main() {
  runApp(AppOngCostura());
}

class AppOngCostura extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ONG Costura',
      theme: appTheme,
      initialRoute: '/',
      routes: appRoutes,
    );
  }
}

