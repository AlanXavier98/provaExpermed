import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prova_expermed/colors/app_colors.dart';
import 'package:prova_expermed/components/cadastro_components/input_cadastro_components_widgets.dart';
import 'package:prova_expermed/data/models/login_model.dart';

class CadastroAlteracaoConsultaScreen extends StatefulWidget {
  LoginModel? user = LoginModel();
  String? label;
  CadastroAlteracaoConsultaScreen(
      {super.key, @required this.user, @required this.label});

  @override
  State<CadastroAlteracaoConsultaScreen> createState() =>
      _CadastroAlteracaoConsultaScreenState();
}

class _CadastroAlteracaoConsultaScreenState
    extends State<CadastroAlteracaoConsultaScreen> {
  late TextEditingController idController;
  late String? label;
  TextEditingController dataConsultaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController estadoController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController ruaController = TextEditingController();
  TextEditingController avaliacaoController = TextEditingController();
  TextEditingController nomePacienteController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    idController = TextEditingController(text: widget.user?.id);
    label = widget.label;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.accentColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          label!,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InputWidgetCadastro(
              ctrl: idController,
              label: "$idController",
              isFixo: true,
            ),
            InputWidgetCadastro(
              ctrl: dataConsultaController,
              label: "Data da consulta",
              isFixo: false,
            ),
            InputWidgetCadastro(
              ctrl: avaliacaoController,
              label: "Avaliação",
              isFixo: false,
            ),
            InputWidgetCadastro(
              ctrl: nomePacienteController,
              label: "Nome do paciente",
              isFixo: false,
            ),
            InputWidgetCadastro(
              ctrl: cidadeController,
              label: "Cidade",
              isFixo: false,
            ),
            InputWidgetCadastro(
              ctrl: estadoController,
              label: "Estado",
              isFixo: false,
            ),
            InputWidgetCadastro(
              ctrl: ruaController,
              label: "Rua",
              isFixo: false,
            ),
            InputWidgetCadastro(
              ctrl: numeroController,
              label: "Número",
              isFixo: false,
            ),
          ],
        ),
      )),
    );
  }
}
