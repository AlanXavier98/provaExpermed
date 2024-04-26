import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prova_expermed/data/http/exceptions.dart';
import 'package:prova_expermed/data/http/http.dart';
import 'package:prova_expermed/data/models/login_model.dart';

class LoginRepositories {
  final HttpClient client;

  LoginRepositories({required this.client});

  @override
  Future<LoginModel> getLogin(
      {@required String? email, @required String? pass}) async {
    // vou colocar mocado aqui para nao ter que ficar digitando o email e a senha ao testar.
    //email = 'Rasheed.Rodriguez16@hotmail.com';
    //pass = 'zKAi7T9AtmzpLqE';
    final response = await client.get(
        url:
            'https://661fc0a416358961cd955f56.mockapi.io/api/v1/user?email=$email&pass=$pass');
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final loginModel = LoginModel.fromJson(body[0]);
      return loginModel;
    } else if (response.statusCode == 404) {
      // aqui poderemos tratar cada erro com uma mensagem diferente.
      throw NotFoundException("URL não é válida");
    } else {
      throw NotFoundException("Erro ao conectar com a API");
    }
  }
}
