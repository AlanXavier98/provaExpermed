import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:prova_expermed/colors/app_colors.dart';
import 'package:prova_expermed/components/login_components/input_component_widget.dart';
import 'package:prova_expermed/components/login_components/logo_component_widget.dart';
import 'package:prova_expermed/screens/calendar_screen.dart';

// A tela de login possui a função para exibir a senha digitada ao clicar no ícone de olho.
// Ao tentar clicar em "Acessar" sem inserir nenhum dado, exibe uma mensagem de erro.
// Para ir para a próxima tela, basta inserir qualquer dado no campo de e-mail ou senha, pois não estou verificando a integridade dos dados, mas sim se há algum dado inserido ou não.

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo
                  LogoComponent(),

                  const SizedBox(
                    height: 20,
                  ),

                  // Email Input
                  InputWidget(
                    ctrl: emailController,
                    label: "E-mail",
                    isPass: false,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // Password Input
                  InputWidget(
                    ctrl: passwordController,
                    label: '*********',
                    isPass: true,
                  ),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: const Text(
                        'Esqueci minha senha',
                        style: TextStyle(
                            color: AppColors.textColorSecondary, fontSize: 12),
                      ),
                    ),
                  ),

                  // Access Button
                  GestureDetector(
                    onTap: () {
                      // Aqui é apenas um exemplo simples, mas seria necessário criar uma função para verificar se o e-mail está preenchido corretamente e se a senha é realmente uma senha e não apenas espaços vazios.
                      if (passwordController.text == "" ||
                          emailController.text == "") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('E-mail ou senha incorretos'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CalendarScreen(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 20.0),
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            AppColors.linearGradientColorPrimary,
                            AppColors.linearGradientColorSecondary
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Acessar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
