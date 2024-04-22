import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prova_expermed/colors/app_colors.dart';
import 'package:prova_expermed/components/info_person_components/text_widget.dart';

// Esta tela exibe os dados do usuário e possui uma pequena função para ocultar os dados ao clicar na seta.

class InfoPerson extends StatefulWidget {
  const InfoPerson({Key? key}) : super(key: key);

  @override
  State<InfoPerson> createState() => _InfoPersonState();
}

class _InfoPersonState extends State<InfoPerson> {
  bool close = true;

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
          '17:00 - Pedro Pedroso',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: AppColors.accentColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
            ),
            child: Padding(
              padding: EdgeInsets.only(right: 20, left: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  close
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              label: 'Cidade: [cidade da agenda]',
                            ),
                            TextWidget(
                              label: 'Estado: [Estado da agenda]',
                            ),
                            TextWidget(
                              label: 'Rua: [rua da agenda]',
                            ),
                            TextWidget(
                              label: 'Número: [número da agenda]',
                            ),
                          ],
                        )
                      : const Text(
                          '...',
                          style: TextStyle(color: Colors.white),
                        ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          close = !close;
                        });
                      },
                      child: const Icon(
                        Icons.expand_less,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
