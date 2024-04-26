import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prova_expermed/data/http/http.dart';
import 'package:prova_expermed/data/models/login_model.dart';
import 'package:prova_expermed/data/repositories/login_repositories.dart';
import 'package:prova_expermed/colors/app_colors.dart';
import 'package:prova_expermed/components/login_components/input_component_widget.dart';
import 'package:prova_expermed/components/login_components/logo_component_widget.dart';
import 'package:prova_expermed/screens/calendar_screen.dart';
import 'package:prova_expermed/services/shared_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

// A tela de login possui a função para exibir a senha digitada ao clicar no ícone de olho.
// Ao tentar clicar em "Acessar" sem inserir nenhum dado, exibe uma mensagem de erro.
// Para ir para a próxima tela, basta inserir qualquer dado no campo de e-mail ou senha, pois não estou verificando a integridade dos dados, mas sim se há algum dado inserido ou não.

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  bool _obscureText = true;
  SharedPref sharedPref = SharedPref();
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
                      if (isLoading != true) {
                        setState(() {
                          isLoading = !isLoading;
                        });
                        if (emailController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Center(
                                child: Text(
                                    'Favor preencher os campos de E-mail e senha.'),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          setState(() {
                            isLoading = !isLoading;
                          });
                        } else {
                          loginUser();
                        }
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
                      child: Center(
                        child: isLoading
                            ? const SizedBox(
                                width: 20.0,
                                height: 20.0,
                                child: CircularProgressIndicator(
                                  color: AppColors.textColor,
                                ),
                              )
                            : const Text(
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

  Future<void> loginUser() async {
    final repository = LoginRepositories(client: Login());
    try {
      final loginModel = await repository.getLogin(
          email: emailController.text, pass: passwordController.text);
      await sharedPref.save('login', loginModel);
      setState(() {
        isLoading = !isLoading;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CalendarScreen(),
        ),
      );
      //final teste = await sharedPref.read('login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(child: Text('Usuário e senha inválidos')),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        isLoading = !isLoading;
      });
    }
  }
}
