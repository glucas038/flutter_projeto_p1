// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projeto_p1/model/usuario.dart';

class RecuperarSenhaView extends StatefulWidget {
  const RecuperarSenhaView({super.key});

  @override
  State<RecuperarSenhaView> createState() => _RecuperarSenhaViewState();
}

class _RecuperarSenhaViewState extends State<RecuperarSenhaView> {
  //Identificador do formulário
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //Controladores dos campos de texto
  final TextEditingController txtEmail = TextEditingController();
  List<Usuario> listaUsuario = [];

  @override
  Widget build(BuildContext context) {
    listaUsuario = ModalRoute.of(context)!.settings.arguments as List<Usuario>;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Recuperar senha',
            style: TextStyle(fontSize: 30),
          ),
          backgroundColor: Colors.greenAccent),
      body: Padding(
        padding: EdgeInsets.fromLTRB(50, 50, 50, 100),
        child: Form(
          key: formKey,
          child: Column(
            children: [
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
                  if (!(listaUsuario
                      .any((usuario) => usuario.email == value))) {
                    return 'Email não existe.';
                  }
                  return null;
                },
              ),

              SizedBox(height: 30),

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
                    //Os campos foram validados com sucesso!

                    //
                    // RECUPERAR as informações dos campos de texto
                    //
                    Navigator.pop(context);

                    setState(() {
                      //Exibir o resultado
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Nova senha enviada para o email'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    });
                  }
                },
                child: Text(
                  'Recuperar senha',
                  style: TextStyle(fontSize: 28),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
