import 'package:flutter/material.dart';

import '../theme/theme_colors.dart';

class CreatePasswordComponent extends StatefulWidget {
  final Function(String) onConfirmTap;

  const CreatePasswordComponent({super.key, required this.onConfirmTap});

  @override
  State<CreatePasswordComponent> createState() =>
      _CreatePasswordComponentState();
}

class _CreatePasswordComponentState extends State<CreatePasswordComponent> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _minimumLength = false;
  bool _passwordsMatch = false;
  String _password = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
              Text(
                'Crie uma senha',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          TextFormField(
            style: const TextStyle(color: Colors.black),
            onChanged: (value) {
              setState(() {
                _password = value;
                _minimumLength = value.length >= 6;
                _passwordsMatch = _password == _confirmPassword;
              });
            },
            decoration: InputDecoration(
              labelText: 'Senha',
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Senha é obrigatório';
              }

              if (value.length < 6) {
                return 'Senha deve ter no mínimo 6 caracteres';
              }
              return null;
            },
            obscureText: _obscurePassword,
          ),
          TextFormField(
            style: const TextStyle(color: Colors.black),
            onChanged: (value) {
              setState(() {
                _confirmPassword = value;
                _minimumLength = _password.length >= 6;
                _passwordsMatch = _password == _confirmPassword;
              });
            },
            decoration: InputDecoration(
              labelText: 'Confirmar Senha',
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Confirmar Senha é obrigatório';
              }
              if (!_passwordsMatch) {
                return 'As senhas não coincidem';
              }
              return null;
            },
            obscureText: _obscureConfirmPassword,
          ),
          Row(
            spacing: 4,
            children: [
              Icon(
                Icons.check,
                color: _minimumLength
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              Text(
                'Mínimo 6 caracteres',
                style: TextStyle(color: ThemeColors.grayLight3),
              ),
            ],
          ),
          Row(
            spacing: 4,
            children: [
              Icon(
                Icons.check,
                color: _passwordsMatch
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              Text(
                'As senhas coincidem',
                style: TextStyle(color: ThemeColors.grayLight3),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // All fields are valid
              }
            },
            child: Text('Concluir'),
          ),
        ],
      ),
    );
  }
}
