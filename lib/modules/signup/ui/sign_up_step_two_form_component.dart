import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/signup/cubit/sign_up_bloc.dart';
import 'package:minhaserigrafia/modules/signup/sign_up_route_navigator.dart';
import 'package:minhaserigrafia/shared/messages.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';
import 'package:minhaserigrafia/shared/ui/custom_snack_bar.dart';

class SignUpStepTwoFormComponent extends StatelessWidget {
  const SignUpStepTwoFormComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final navigator = Modular.get<SignUpRouteNavigator>();

    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) =>
          _handleSignUpState(state, context, navigator),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _EmailInput(),
          const Padding(padding: EdgeInsets.all(12)),
          _PasswordInput(),
          const Padding(padding: EdgeInsets.all(12)),
          _ConfirmPasswordInput(),
          const Padding(padding: EdgeInsets.all(12)),
          _SaveButton(),
        ],
      ),
    );
  }

  void _handleSignUpState(
    SignUpState state,
    BuildContext context,
    SignUpRouteNavigator navigator,
  ) {
    if (state.status.isFailure) {
      if (state.isEmailInUse) {
        showCustomSnackBar(context, 'Email já cadastrado.');
      } else {
        final message = '$genericErrorMessage ${state.errorCode}';
        showCustomSnackBar(context, message);
      }
    } else if (state.status.isSuccess) {
      navigator.goTo(homeRoute);
    }
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpCubit bloc) => bloc.state.email.displayError,
    );

    return TextField(
      onChanged: (email) {
        BlocProvider.of<SignUpCubit>(context).onEmailChanged(email);
      },
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: 'Email',
        errorText: displayError != null ? 'Email inválido.' : null,
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
      (SignUpCubit bloc) => bloc.state.password.displayError,
    );

    final isPasswordEquals = context.select(
      (SignUpCubit bloc) => bloc.state.isPasswordNotEqual,
    );

    return TextField(
      onChanged: (password) {
        BlocProvider.of<SignUpCubit>(context).onPasswordChanged(password);
      },
      obscureText: _obscurePassword,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: 'Senha',
        errorText: displayError != null
            ? 'Mínimo 6 caracteres'
            : isPasswordEquals
            ? 'As senhas não conferem'
            : null,
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

class _ConfirmPasswordInput extends StatefulWidget {
  const _ConfirmPasswordInput();

  @override
  State<_ConfirmPasswordInput> createState() => _ConfirmPasswordInputState();
}

class _ConfirmPasswordInputState extends State<_ConfirmPasswordInput> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpCubit bloc) => bloc.state.confirmPassword.displayError,
    );

    final isPasswordEquals = context.select(
      (SignUpCubit bloc) => bloc.state.isPasswordNotEqual,
    );

    return TextField(
      onChanged: (password) {
        BlocProvider.of<SignUpCubit>(
          context,
        ).onConfirmPasswordChanged(password);
      },
      obscureText: _obscurePassword,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: 'Confirmar Senha',
        errorText: displayError != null
            ? 'Mínimo 6 caracteres'
            : isPasswordEquals
            ? 'As senhas não conferem'
            : null,
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

class _SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (SignUpCubit bloc) => bloc.state.status.isInProgress,
    );

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select(
      (SignUpCubit bloc) => bloc.state.isStepTwoValid,
    );

    return ElevatedButton(
      onPressed: isValid
          ? () {
              BlocProvider.of<SignUpCubit>(context).onSignUpSubmitted();
            }
          : null,
      child: const Text('Concluir'),
    );
  }
}
