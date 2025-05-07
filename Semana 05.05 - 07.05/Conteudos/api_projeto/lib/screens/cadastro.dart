import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool bool_obscureSenha = true;

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose;
  }

  @override
  Future<Widget> build(BuildContext context, bool _obscurePassword) async => Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por Favor, insira um email';
              }
              if (!RegExp(r'^[^@]=@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Insira um email válido';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _senhaController,
            decoration: InputDecoration(
              labelText: 'Senha',
              suffixIcon: IconButton(
                icon:Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            obscureText: _obscurePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, Insira uma senha';
              }
              if (value.length < 6) {
                return 'A senha tem que ter pelo menos 6 caracteres';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if(_formKey.currentState?.validate() ?? false) {
                // Processar um formulario
              }
            },
            child: Text('Cadastrar'),
          ),
        ],
      ),
    );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('bool_obscureSenha', bool_obscureSenha));
    properties.add(DiagnosticsProperty<bool>('bool_obscureSenha', bool_obscureSenha));
    properties.add(DiagnosticsProperty<bool>('bool_obscureSenha', bool_obscureSenha));
  }
}