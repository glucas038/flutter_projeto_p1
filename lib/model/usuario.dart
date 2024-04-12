import 'package:flutter_projeto_p1/model/lista.dart';

class Usuario {
  String nome;
  String cpf;
  String email;
  String senha;
  List<ListaCompra> listaCompras = [];

  Usuario(this.nome, this.cpf, this.email, this.senha);
}
