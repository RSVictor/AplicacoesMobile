import 'package:appdeliverytb/ui/_core/app_colors.dart';
import 'package:appdeliverytb/ui/widgets/login/login.dart';  // Importe a tela de login
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Redireciona para a tela de Login após 3 segundos
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()), // Navega para a tela de login
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          Image.asset('assets/banners/banner_splash.png'), // Imagem de fundo
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 32,
                children: [
                  Image.asset('assets/logo.png', width: 192), // Logo
                  Column(
                    children: [
                      Text(
                        'Um parceiro inovador para sua',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      Text(
                        'Melhor experiencia culinária',
                        style: TextStyle(
                          color: AppColors.mainColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // O botão "Bora" não é mais necessário, já que a navegação é feita automaticamente
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
