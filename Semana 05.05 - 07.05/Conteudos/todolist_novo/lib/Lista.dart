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
        const SnackBar(content: Text("O título da tarefa não pode ser vazio.")),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      if (_tarefaEditandoId == null) {
        // Adiciona uma nova tarefa
        await _tarefasRef.add({'titulo': titulo, 'concluida': false});
      } else {
        // Atualiza uma tarefa existente
        await _tarefasRef.doc(_tarefaEditandoId).update({'titulo': titulo});
        _tarefaEditandoId = null; // Reseta o estado de edição
      }
      _tarefaController.clear(); // Limpa o campo de entrada
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao salvar a tarefa: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _removerTarefa(String id) async {
    try {
      await _tarefasRef.doc(id).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tarefa removida com sucesso!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao remover a tarefa: $e")),
      );
    }
  }

  Future<void> _confirmarRemoverTodas() async {
    final bool? confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmar Exclusão"),
        content: const Text("Tem certeza que deseja remover todas as tarefas?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancelar")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Remover")),
        ],
      ),
    );

    if (confirmar == true) {
      try {
        final snapshot = await _tarefasRef.get();
        for (var doc in snapshot.docs) {
          await doc.reference.delete();
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Todas as tarefas foram removidas.")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao remover todas as tarefas: $e")),
        );
      }
    }
  }

  Future<void> _atualizarStatus(String id, bool concluida) async {
    try {
      await _tarefasRef.doc(id).update({'concluida': concluida});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao atualizar o status da tarefa: $e")),
      );
    }
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
              decoration: const InputDecoration(
                labelText: "Digite uma tarefa",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: _isLoading ? null : _adicionarOuEditarTarefa,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(_tarefaEditandoId == null ? "Adicionar Tarefa" : "Atualizar Tarefa"),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _tarefasRef.orderBy('concluida', descending: false).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                  final docs = snapshot.data!.docs;

                  if (docs.isEmpty) {
                    return const Center(child: Text("Nenhuma tarefa adicionada."));
                  }

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
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  _tarefaController.text = data["titulo"];
                                  setState(() {
                                    _tarefaEditandoId = doc.id;
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
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
                                  concluidaInicial: data["concluida"],
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
        child: const Icon(Icons.delete),
        backgroundColor: Colors.red,
      ),
    );
  }
}