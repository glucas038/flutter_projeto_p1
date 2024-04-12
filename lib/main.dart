// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projeto_p1/view/cadastro_view.dart';
import 'package:flutter_projeto_p1/view/item_view.dart';
import 'package:flutter_projeto_p1/view/lista_view.dart';
import 'package:flutter_projeto_p1/view/login_view.dart';
import 'package:flutter_projeto_p1/view/recuperar_senha_view.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de compra',
      initialRoute: 'login',
      routes: {
        'lista': (context) => ListaView(),
        'item': (context) => ItemView(),
        'login': (context) => LoginView(),
        'cadastro': (context) => CadastroView(),
        'recuperar': (context) => RecuperarSenhaView(),
      },
    );
  }
}
