import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prova_expermed/colors/app_colors.dart';

class TextWidget extends StatelessWidget {
  //label é o texto a ser exibido
  var label;
  TextWidget({@required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(color: AppColors.textColor, fontSize: 14),
    );
  }
}
