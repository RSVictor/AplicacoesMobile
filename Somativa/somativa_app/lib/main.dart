import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';

import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/menu_page.dart';
import 'pages/cart_page.dart';
import 'pages/confirm_page.dart';

void main() {
  runApp(MangeEats());
}

class MangeEats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'PedeEntregue',
        debugShowCheckedModeBanner: false,
        initialRoute: "/login",
        routes: {
          "/login": (_) => LoginPage(),
          "/register": (_) => RegisterPage(),
          "/menu": (_) => MenuPage(),
          "/cart": (_) => CartPage(),
        },
      ),
    );
  }
}
