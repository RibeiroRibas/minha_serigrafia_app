import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/signin/cubit/login_with_email_and_password_cubit.dart';
import 'package:minhaserigrafia/modules/signin/exceptions/error_messages.dart';
import 'package:minhaserigrafia/modules/signin/sign_in_route_navigator.dart';
import 'package:minhaserigrafia/shared/error_messages.dart' as error_message;
import 'package:minhaserigrafia/shared/routes/route_named.dart';
import 'package:minhaserigrafia/shared/ui/custom_snack_bar.dart';

class LoginFormComponent extends StatelessWidget {
  const LoginFormComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final navigator = Modular.get<SignInRouteNavigator>();

    return BlocListener<
      LoginWithEmailAndPasswordCubit,
      LoginWithEmailAndPasswordState
    >(
      listener: (context, state) {
        if (state.status.isFailure) {
          if (state.errorMessage == invalidFirebaseUserCredentials) {
            showCustomSnackBar(context, invalidFirebaseUserCredentials);
          } else {
            final message = error_message.fromErrorCode(state.errorCode);
            showCustomSnackBar(context, message);
          }
        } else if (state.status.isSuccess) {
          navigator.goTo(homeRoute);
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
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (LoginWithEmailAndPasswordCubit bloc) => bloc.state.email.displayError,
    );

    return TextField(
      key: const Key('loginForm_usernameInput_textField'),
      onChanged: (email) {
        BlocProvider.of<LoginWithEmailAndPasswordCubit>(
          context,
        ).onEmailChanged(email);
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
      (LoginWithEmailAndPasswordCubit bloc) => bloc.state.password.displayError,
    );

    return TextField(
      key: const Key('loginForm_passwordInput_textField'),
      onChanged: (password) {
        BlocProvider.of<LoginWithEmailAndPasswordCubit>(
          context,
        ).onPasswordChanged(password);
      },
      obscureText: _obscurePassword,
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
      (LoginWithEmailAndPasswordCubit bloc) => bloc.state.status.isInProgress,
    );

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select(
      (LoginWithEmailAndPasswordCubit bloc) => bloc.state.isValid,
    );

    return ElevatedButton(
      key: const Key('loginForm_continue_raisedButton'),
      onPressed: isValid
          ? () {
              BlocProvider.of<LoginWithEmailAndPasswordCubit>(
                context,
              ).onSignInWithEmailSubmitted();
            }
          : null,
      child: const Text('Entrar'),
    );
  }
}
