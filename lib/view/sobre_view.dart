import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Importe o pacote url_launcher

class SobreView extends StatefulWidget {
  const SobreView({Key? key}) : super(key: key);

  @override
  State<SobreView> createState() => _SobreViewState();
}

class _SobreViewState extends State<SobreView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Sobre o app"),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 600), // Limita a largura máxima
          padding: EdgeInsets.all(screenWidth * 0.05), // 5% do tamanho da tela
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Boas-vindas ao nosso aplicativo de listas de compras!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  "Com um visual que harmoniza tons de verde e branco, "
                  "queremos facilitar a sua rotina de compras diárias. "
                  "Desenvolvido por Lucas Gabriel, estamos comprometidos"
                  " em tornar suas compras mais ágeis e eficientes.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 32.0), // Adiciona espaçamento
                GestureDetector(
                  onTap: _launchUrl, // Chama a função para abrir o Instagram
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Siga-me no Instagram: ",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Image.asset(
                        //'lib/imagens/insta.png',
                        'lib/imagens/insta.png',
                        width: screenWidth * 0.04, // 4% do tamanho da tela
                        height: screenWidth * 0.04, // 4% do tamanho da tela
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Função para abrir o Instagram
  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse('https://www.instagram.com/glucas038/');
    if (await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
