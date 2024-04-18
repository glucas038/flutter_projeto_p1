import 'package:flutter/material.dart';
import 'package:flutter_projeto_p1/model/item.dart';
import 'package:flutter_projeto_p1/model/lista.dart';

class ListaView extends StatefulWidget {
  const ListaView({Key? key});

  @override
  State<ListaView> createState() => _ListaViewState();
}

class _ListaViewState extends State<ListaView> {
  //
  // Lista Dinâmica de objetos da classe Contato
  //
  List<ListaCompra> listas = [];

  @override
  Widget build(BuildContext context) {
    listas = ModalRoute.of(context)!.settings.arguments as List<ListaCompra>;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text('Lista de Compras'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          //Quantidade de itens
          itemCount: listas.length,

          //Aparência de cada item
          itemBuilder: (context, index) {
            return Card(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    List<Item> enviarItens = listas[index].listaItens;

                    Navigator.pushNamed(context, 'item',
                        arguments: enviarItens);
                  },
                  child: ListTile(
                    title: Text(listas[index].nome),
                    subtitle: Text('Quantidade de itens'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Implemente a lógica de edição aqui
                            _editarItem(context, index);
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            // Implemente a lógica de exclusão aqui
                            _excluirItem(context, index);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _exibirPopupAdicionarItem(context, '', -1);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.greenAccent,
      ),
    );
  }

  void _editarItem(BuildContext context, int index) {
    // Implemente a lógica de edição aqui
    // Exemplo:
    _exibirPopupAdicionarItem(context, listas[index].nome, index);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Editar a lista ${listas[index].nome}'),
      ),
    );
  }

  void _excluirItem(BuildContext context, int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Excluir a lista ${listas[index].nome}'),
      ),
    );
    setState(() {
      listas.removeAt(index);
    });
  }

  void _exibirPopupAdicionarItem(BuildContext context, String nome, int index) {
    TextEditingController nomeController = TextEditingController();

    nomeController.text = nome;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adicionar lista'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nomeController.text.isNotEmpty) {
                  if (index == -1) {
                    setState(() {
                      listas.add(
                        ListaCompra(nomeController.text),
                      );
                    });
                  }

                  if (index != -1) {
                    setState(() {
                      listas[index].nome = nomeController.text;
                    });
                  }

                  Navigator.of(context).pop();
                } else {
                  // Mostrar um alerta ou uma mensagem informando que os campos não podem estar vazios
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Por favor, preencha todos os campos.'),
                    ),
                  );
                }
              },
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}
