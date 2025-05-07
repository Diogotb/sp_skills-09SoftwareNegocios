import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TarefaDetalhes extends StatefulWidget {
  final String tarefaId;
  final String tituloInicial;
  final bool concluidaInicial;

  const TarefaDetalhes({
    Key? key,
    required this.tarefaId,
    required this.tituloInicial,
    required this.concluidaInicial,
  }) : super(key: key);

  @override
  _TarefaDetalhesState createState() => _TarefaDetalhesState();
}

class _TarefaDetalhesState extends State<TarefaDetalhes> {
  late TextEditingController _tituloController;
  bool _isLoading = false;
  late bool _concluida;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.tituloInicial);
    _concluida = widget.concluidaInicial;
  }

  @override
  void dispose() {
    _tituloController.dispose();
    super.dispose();
  }

  Future<void> _salvarAlteracoes() async {
    if (_tituloController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("O título não pode ser vazio.")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirebaseFirestore.instance.collection('tarefas').doc(widget.tarefaId).update({
        'titulo': _tituloController.text.trim(),
        'concluida': _concluida,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tarefa atualizada com sucesso!")),
      );

      Navigator.pop(context, true); // Retorna um indicador de sucesso
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao atualizar a tarefa: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<bool?> _confirmarRemocao() async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmar Exclusão"),
        content: const Text("Tem certeza que deseja remover esta tarefa?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Remover"),
          ),
        ],
      ),
    );
  }

  Future<void> _removerTarefa() async {
    final confirmar = await _confirmarRemocao();
    if (confirmar == true) {
      setState(() => _isLoading = true);
      try {
        await FirebaseFirestore.instance.collection('tarefas').doc(widget.tarefaId).delete();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Tarefa removida com sucesso!")),
        );
        Navigator.pop(context, true); // Retorna um indicador de sucesso
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao remover a tarefa: $e")),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes da Tarefa"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Título:", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Digite o título da tarefa",
                ),
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                title: const Text("Concluída"),
                value: _concluida,
                onChanged: (value) {
                  setState(() {
                    _concluida = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _salvarAlteracoes,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Salvar Alterações"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _isLoading ? null : _removerTarefa,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text("Remover Tarefa"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}