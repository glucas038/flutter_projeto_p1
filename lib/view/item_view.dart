import 'package:flutter/material.dart';
import 'package:flutter_projeto_p1/model/item.dart';

class ItemView extends StatefulWidget {
  const ItemView({Key? key});

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  //
  // Lista Dinâmica de objetos da classe Contato
  //
  List<Item> itens = [];
  List<Item> itensFiltrados = [];

  TextEditingController txtFiltro = TextEditingController();

  @override
  Widget build(BuildContext context) {
    itens = ModalRoute.of(context)!.settings.arguments as List<Item>;
    // Verificar se o campo de filtro está vazio
    itensFiltrados.clear();
    if (txtFiltro.text.isEmpty) {
      itensFiltrados.addAll(itens); // Inicialize com todos os itens
    } else {
      filtrarItens(txtFiltro
          .text); // Filtrar os itens com base no texto do campo de filtro
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: const Text('Itens'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: txtFiltro,
              decoration: const InputDecoration(labelText: 'Pesquisar item'),
              onChanged: (value) {
                filtrarItens(value);
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              // Para garantir que a ListView ocupe todo o espaço disponível
              child: ListView.builder(
                //Quantidade de itens
                itemCount: itensFiltrados.length,

                //Aparência de cada item
                itemBuilder: (context, index) {
                  return Card(
                    color: itensFiltrados[index].comprado
                        ? Colors.greenAccent
                        : Colors.white,
                    child: ListTile(
                      title: Text(itensFiltrados[index].nome),
                      subtitle: Text(itensFiltrados[index].quantidade),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              // Implemente a lógica de edição aqui
                              _editarItem(context, index);
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              // Implemente a lógica de exclusão aqui
                              _excluirItem(context, index);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                          IconButton(
                            icon: itensFiltrados[index].comprado
                                ? const Icon(Icons.shopping_cart)
                                : const Icon(Icons.shopping_cart_outlined),
                            onPressed: () {
                              _mudarCompra(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _exibirPopupAdicionarItem(context, '', '', -1);
        },
        backgroundColor: Colors.greenAccent,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void filtrarItens(String value) {
    String filtro = value.toLowerCase();
    setState(() {
      itensFiltrados
          .clear(); // Limpar a lista antes de adicionar os itens filtrados
      itensFiltrados.addAll(itens.where((item) {
        return item.nome.toLowerCase().startsWith(filtro);
      }).toList());
    });
  }

  void _mudarCompra(int index) {
    setState(() {
      int newIndex = itens.indexWhere((item) => item == itensFiltrados[index]);
      itens[newIndex].comprado = !itens[newIndex].comprado;
    });
  }

  void _editarItem(BuildContext context, int index) {
    // Implemente a lógica de edição aqui
    // Exemplo:
    int newIndex = itens.indexWhere((item) => item == itensFiltrados[index]);
    _exibirPopupAdicionarItem(
        context, itens[newIndex].nome, itens[newIndex].quantidade, newIndex);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Editar o item ${itens[newIndex].nome}'),
      ),
    );
  }

  void _excluirItem(BuildContext context, int index) {
    int newIndex = itens.indexWhere((item) => item == itensFiltrados[index]);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Excluir o item ${itens[newIndex].nome}'),
      ),
    );
    setState(() {
      itens.removeAt(newIndex);
      itensFiltrados;
    });
  }

  void _exibirPopupAdicionarItem(
      BuildContext context, String nome, String quantidade, int index) {
    TextEditingController nomeController = TextEditingController();
    TextEditingController quantidadeController = TextEditingController();
    nomeController.text = nome;
    quantidadeController.text = quantidade;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: quantidadeController,
                decoration: const InputDecoration(labelText: 'Quantidade'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nomeController.text.isNotEmpty &&
                    quantidadeController.text.isNotEmpty) {
                  if (index == -1) {
                    setState(() {
                      itens.add(
                        Item(nomeController.text, quantidadeController.text),
                      );
                    });
                  }

                  if (index != -1) {
                    setState(() {
                      itens[index].nome = nomeController.text;
                      itens[index].quantidade = quantidadeController.text;
                    });
                  }

                  Navigator.of(context).pop();
                } else {
                  // Mostrar um alerta ou uma mensagem informando que os campos não podem estar vazios
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor, preencha todos os campos.'),
                    ),
                  );
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}
