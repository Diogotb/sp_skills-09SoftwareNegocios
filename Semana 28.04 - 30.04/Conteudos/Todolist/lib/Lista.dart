import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/ListaDetalhes.dart';

class ListaTarefas extends StatefulWidget {
  @override
  _ListaTarefasState createState() => _ListaTarefasState();
}

class _ListaTarefasState extends State<ListaTarefas> {
  final TextEditingController _tarefaController = TextEditingController();
  final CollectionReference _tarefasRef = FirebaseFirestore.instance.collection('tarefas');
  String? _tarefaEditandoId;
  bool _isLoading = false;

  Future<void> _adicionarOuEditarTarefa() async {
    final titulo = _tarefaController.text.trim();
    if (titulo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("O título da tarefa não pode ser vazio.")),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      if (_tarefaEditandoId == null) {
        await _tarefasRef.add({'titulo': titulo, 'concluida': false});
      } else {
        await _tarefasRef.doc(_tarefaEditandoId).update({'titulo': titulo});
        _tarefaEditandoId = null;
      }
      _tarefaController.clear();
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _removerTarefa(String id) async {
    await _tarefasRef.doc(id).delete();
  }

  Future<void> _confirmarRemoverTodas() async {
    bool? confirmar = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmar Exclusão"),
        content: Text("Tem certeza que deseja remover todas as tarefas?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text("Cancelar")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text("Remover")),
        ],
      ),
    );

    if (confirmar == true) {
      final snapshot = await _tarefasRef.get();
      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    }
  }

  Future<void> _atualizarStatus(String id, bool concluida) async {
    await _tarefasRef.doc(id).update({'concluida': concluida});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To Do List")),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            TextField(
              controller: _tarefaController,
              decoration: InputDecoration(labelText: "Coloque uma tarefa"),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: _isLoading ? null : _adicionarOuEditarTarefa,
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text(_tarefaEditandoId == null ? "Adicionar Tarefa" : "Atualizar Tarefa"),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _tarefasRef.orderBy('concluida', descending: false).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

                  final docs = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      final data = doc.data() as Map<String, dynamic>;

                      return Card(
                        child: ListTile(
                          title: Text(
                            data["titulo"],
                            style: TextStyle(
                              decoration: data["concluida"] ? TextDecoration.lineThrough : null,
                            ),
                          ),
                          leading: Checkbox(
                            value: data["concluida"],
                            onChanged: (valor) => _atualizarStatus(doc.id, valor ?? false),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  _tarefaController.text = data["titulo"];
                                  setState(() {
                                    _tarefaEditandoId = doc.id;
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => _removerTarefa(doc.id),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TarefaDetalhes(
                                  tarefaId: doc.id,
                                  tituloInicial: data["titulo"],
                                  concluida: data["concluida"],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _confirmarRemoverTodas,
        child: Icon(Icons.delete),
      ),
    );
  }
}
