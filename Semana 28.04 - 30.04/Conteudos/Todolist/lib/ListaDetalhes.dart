import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TarefaDetalhes extends StatefulWidget {
  final String tarefaId;
  final String tituloInicial;
  bool concluida;

  TarefaDetalhes({
    required this.tarefaId,
    required this.tituloInicial,
    required this.concluida,
  });

  @override
  _TarefaDetalhesState createState() => _TarefaDetalhesState();
}

class _TarefaDetalhesState extends State<TarefaDetalhes> {
  late TextEditingController _tituloController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.tituloInicial);
  }

  @override
  void dispose() {
    _tituloController.dispose();
    super.dispose();
  }

  Future<void> _salvarAlteracoes() async {
    if (_tituloController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("O título não pode ser vazio.")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirebaseFirestore.instance
          .collection('tarefas')
          .doc(widget.tarefaId)
          .update({
        'titulo': _tituloController.text.trim(),
        'concluida': widget.concluida,
      });

      Navigator.pop(context);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _confirmarRemocao() async {
    bool? confirmar = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmar Exclusão"),
        content: Text("Tem certeza que deseja remover esta tarefa?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("Remover"),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      setState(() => _isLoading = true);
      try {
        await FirebaseFirestore.instance
            .collection('tarefas')
            .doc(widget.tarefaId)
            .delete();

        Navigator.pop(context);
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalhes da Tarefa")),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Título:", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text("Concluída"),
              value: widget.concluida,
              onChanged: (value) {
                setState(() {
                  widget.concluida = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _salvarAlteracoes,
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Salvar Alterações"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _isLoading ? null : _confirmarRemocao,
              child: Text("Remover Tarefa"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
