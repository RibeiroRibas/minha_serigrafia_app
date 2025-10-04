import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/signin/bloc/login_with_email_and_password_bloc.dart';
import 'package:minhaserigrafia/modules/signin/exceptions/error_messages.dart';
import 'package:minhaserigrafia/shared/messages.dart';

class LoginFormComponent extends StatelessWidget {
  const LoginFormComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          Modular.get<LoginWithEmailAndPasswordBloc>(),
      child:
          BlocListener<
            LoginWithEmailAndPasswordBloc,
            LoginWithEmailAndPasswordState
          >(
            listener: (context, state) {
              if (state.status.isFailure) {
                if (state.errorMessage == invalidFirebaseUserCredentials) {
                  scaffoldMessage(context, invalidFirebaseUserCredentials);
                } else {
                  String message = '$genericErrorMessage ${state.errorCode}';
                  scaffoldMessage(context, message);
                }
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _UsernameInput(),
                const Padding(padding: EdgeInsets.all(12)),
                _PasswordInput(),
                const Padding(padding: EdgeInsets.all(12)),
                _LoginButton(),
              ],
            ),
          ),
    );
  }

  void scaffoldMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginWithEmailAndPasswordBloc bloc) => bloc.state.username.displayError,
    );

    return TextField(
      key: const Key('loginForm_usernameInput_textField'),
      onChanged: (email) {
        Modular.get<LoginWithEmailAndPasswordBloc>().add(
          LoginUsernameChanged(email),
        );
      },
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: 'E-mail',
        errorText: displayError != null ? 'E-mail inválido.' : null,
      ),
    );
  }
}

class _PasswordInput extends StatefulWidget {
  const _PasswordInput();

  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginWithEmailAndPasswordBloc bloc) => bloc.state.password.displayError,
    );

    return TextField(
      key: const Key('loginForm_passwordInput_textField'),
      onChanged: (password) {
        Modular.get<LoginWithEmailAndPasswordBloc>().add(
          LoginPasswordChanged(password),
        );
      },
      obscureText: true,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: 'Senha',
        errorText: displayError != null ? 'Campo senha é obrigatório.' : null,
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
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (LoginWithEmailAndPasswordBloc bloc) => bloc.state.status.isInProgress,
    );

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select(
      (LoginWithEmailAndPasswordBloc bloc) => bloc.state.isValid,
    );

    return ElevatedButton(
      onPressed: () {
        if (isValid) {
          Modular.get<LoginWithEmailAndPasswordBloc>().add(
            const LoginWithEmailAndPasswordSubmitted(),
          );
        }
      },
      child: const Text('Entrar'),
    );
  }
}
