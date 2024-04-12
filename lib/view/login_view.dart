// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projeto_p1/model/item.dart';
import 'package:flutter_projeto_p1/model/lista.dart';
import 'package:flutter_projeto_p1/model/usuario.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  List<Usuario> listaUsuario = [];

  //Identificador do formulário
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //Controladores dos campos de texto
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtSenha = TextEditingController();

  bool senhaVisivel = false;

  @override
  void initState() {
    listaUsuario.addAll([
      Usuario('Lucas', '46780770817', 'lucas@gmail.com', '123456789'),
      Usuario('Plotze', '82576907083', 'plotze@gmail.com', '123456789')
    ]);

    listaUsuario[0]
        .listaCompras
        .addAll([ListaCompra('Final de semana'), ListaCompra('Churrasco')]);
    listaUsuario[0].listaCompras[0].listaItens.addAll([
      Item('Arroz', '1 saco de 5kg'),
      Item('Coca Cola Zero', '2 de dois litros'),
      Item('Filão', '5')
    ]);

    listaUsuario[0]
        .listaCompras[1]
        .listaItens
        .add(Item('Coca Cola', ' de dois litros'));

    listaUsuario[1].listaCompras.add(ListaCompra('Churrasco da turma'));
    listaUsuario[1].listaCompras[0].listaItens.addAll([
      Item('Picanha', '5kg'),
      Item('Coca Cola', '10 de dois litros'),
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(50, 75, 50, 100),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              //
              // IMAGEM
              //
              Image.asset(
                'lib/imagens/compras.png',
                width: 300,
                height: 200,
              ),
              SizedBox(height: 10),
              //
              // CAMPO DE TEXTO
              //
              TextFormField(
                controller: txtEmail,
                style: TextStyle(fontSize: 26),
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                ),
                //
                // Validação
                //
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe um e-mail.';
                  }
                  if (!EmailValidator.validate(value)) {
                    return 'Informe um e-mail valido.';
                  }

                  index = listaUsuario
                      .indexWhere((usuario) => usuario.email == value);
                  if (!(index != -1)) {
                    return "Email não existe";
                  }

                  return null;
                },
              ),

              SizedBox(height: 30),

              TextFormField(
                controller: txtSenha,
                style: TextStyle(fontSize: 26),
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(senhaVisivel
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                    onPressed: () {
                      setState(() {
                        senhaVisivel = !senhaVisivel;
                      });
                    },
                  ),
                ),
                obscureText: !senhaVisivel,
                //
                // Validação
                //
                validator: (value) {
                  if (value == null) {
                    return 'Informe um valor';
                  } else if (value.isEmpty) {
                    return 'Informe um valor';
                  }
                  print(listaUsuario[index].senha);
                  if (listaUsuario[index].senha != value) {
                    return 'Senha incorreta';
                  }

                  //Retornar null significa que o campo
                  //foi validado com sucesso!
                  return null;
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'recuperar',
                            arguments: listaUsuario);
                      },
                      child: Text('Esqueceu a senha?')),
                ],
              ),

              SizedBox(height: 10),

              //
              // BOTÃO
              //
              //ElevatedButton, OutlinedButton, TextButton
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade100,
                  foregroundColor: Colors.black87,
                  minimumSize: Size(200, 40),
                ),
                onPressed: () {
                  //
                  // Chamar os VALIDADORES
                  //
                  if (formKey.currentState!.validate()) {
                    Navigator.pushNamed(context, 'lista',
                        arguments: listaUsuario[index].listaCompras);
                  }
                },
                child: Text(
                  'Entrar',
                  style: TextStyle(fontSize: 28),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellowAccent.shade100,
                    foregroundColor: Colors.black87,
                    minimumSize: Size(200, 40),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'cadastro',
                        arguments: listaUsuario);
                  },
                  child: Text(
                    'Cadastrar',
                    style: TextStyle(fontSize: 28),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
