import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projeto_p1/model/usuario.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CadastroView extends StatefulWidget {
  const CadastroView({super.key});

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
  var formKey = GlobalKey<FormState>();

  //Controladores dos campos de texto
  var txtPrimeiroNome = TextEditingController();
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();
  var txtCpf = TextEditingController();

  List<Usuario> listaUsuario = [];

  @override
  Widget build(BuildContext context) {
    double forca = 0;
    listaUsuario = ModalRoute.of(context)!.settings.arguments as List<Usuario>;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Novo cadastro',
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
                controller: txtPrimeiroNome,
                style: TextStyle(fontSize: 26),
                decoration: InputDecoration(
                  labelText: 'Primeiro nome',
                  border: OutlineInputBorder(),
                ),
                //
                // Validação
                //
                validator: (value) {
                  if (value == null) {
                    return 'Informe um nome';
                  } else if (value.isEmpty) {
                    return 'Informe um nome';
                  }
                  return null;
                },
              ),

              SizedBox(height: 30),

              TextFormField(
                controller: txtCpf,
                style: TextStyle(fontSize: 26),
                decoration: InputDecoration(
                  labelText: 'CPF',
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  MaskTextInputFormatter(mask: '###.###.###-##')
                ],
                //
                // Validação
                //
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe um CPF.';
                  }
                  if (!CPFValidator.isValid(value)) {
                    return 'Informe um CPF valido.';
                  }
                  String newCpf = value.replaceAll(RegExp(r'[.-]'), '');

                  if (listaUsuario.any((usuario) => usuario.cpf == newCpf)) {
                    return 'CPF já cadastrado.';
                  }

                  return null;
                },
              ),

              SizedBox(height: 30),

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
                  if (value == null) {
                    return 'Informe um e-mail.';
                  } else if (value.isEmpty) {
                    return 'Informe um e-mail.';
                  }
                  if (!EmailValidator.validate(value)) {
                    return 'Informe um e-mail valido.';
                  }
                  if (listaUsuario.any((usuario) => usuario.email == value)) {
                    return 'E-mail já cadastrado .';
                  }

                  //Retornar null significa que o campo
                  //foi validado com sucesso!
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
                ),
                onChanged: (value) {
                  setState(() {
                    forca = calcularForcaSenha(value);
                    calcularCor(forca);
                  });
                },
                //
                // Validação
                //
                validator: (value) {
                  if (value == null) {
                    return 'Informe um valor';
                  } else if (value.isEmpty) {
                    return 'Informe um valor';
                  }
                  if (calcularForcaSenha(value) < 0.4) {
                    return 'Senha muito fraca.';
                  }

                  //Retornar null significa que o campo
                  //foi validado com sucesso!
                  return null;
                },
              ),
              LinearProgressIndicator(
                value: calcularForcaSenha(txtSenha.text),
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                    calcularCor(calcularForcaSenha(txtSenha.text))),
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
                  // Chamar os VALIDADORES
                  if (formKey.currentState!.validate()) {
                    listaUsuario.add(Usuario(txtPrimeiroNome.text, txtCpf.text,
                        txtEmail.text, txtSenha.text));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Cadastrado com sucesso!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Cadastrar',
                  style: TextStyle(fontSize: 28),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double calcularForcaSenha(String senha) {
    int comprimento = senha.length;
    if (comprimento < 6) {
      return 0.2; // Muito fraca
    } else if (comprimento < 8) {
      return 0.4; // Fraca
    } else if (comprimento < 10) {
      return 0.6; // Média
    } else if (comprimento < 12) {
      return 0.8; // Forte
    } else {
      return 1.0; // Muito forte
    }
  }

  Color calcularCor(double forca) {
    if (forca == 0.2) {
      return Colors.redAccent; // Muito fraca
    } else if (forca == 0.4) {
      return Colors.orangeAccent; // Fraca
    } else if (forca == 0.6) {
      return Colors.yellowAccent; // Média
    } else if (forca == 0.8) {
      return Colors.greenAccent.shade100; // Forte
    } else {
      return Colors.greenAccent.shade700; // Muito forte
    }
  }
}
