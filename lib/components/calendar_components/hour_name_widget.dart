import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prova_expermed/colors/app_colors.dart';

class HourName extends StatelessWidget {
  // Esta tela exibe o label como os dados do usuário
  // A func recebe a função para trocar de tela.
  var label;
  var func;
  var editFunc;
  var deleteFunc;
  HourName(
      {@required this.label,
      @required this.editFunc,
      @required this.func,
      @required this.deleteFunc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(5),
        decoration: const BoxDecoration(
          color: AppColors.accentColor,
          border: Border(
            left: BorderSide(width: 2, color: Colors.white),
            top: BorderSide(width: 1, color: Colors.black),
            right: BorderSide(width: 1, color: Colors.black),
            bottom: BorderSide(width: 1, color: Colors.black),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                ' $label',
                style: TextStyle(fontSize: 16, color: AppColors.textColor),
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit, color: AppColors.textColor),
              onPressed: editFunc,
            ),
            IconButton(
              icon: Icon(Icons.delete, color: AppColors.textColor),
              onPressed: deleteFunc,
            ),
          ],
        ),
      ),
    );
  }
}
