import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/company/company_route_navigator.dart';
import 'package:minhaserigrafia/modules/company/cubit/user_access_cubit.dart';
import 'package:minhaserigrafia/shared/messages.dart';
import 'package:minhaserigrafia/shared/ui/custom_snack_bar.dart';

class CreateAccessComponent extends StatelessWidget {
  const CreateAccessComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final navigator = Modular.get<CompanyRouteNavigator>();

    return BlocListener<UserAccessCubit, UserAccessState>(
      listener: (context, state) =>
          _handleCreateAccessState(state, context, navigator),
      child: Column(
        spacing: 8.0,
        children: [
          _UserNameInput(),
          const SizedBox(height: 12),
          _EmailInput(),
          const SizedBox(height: 12),
          _PasswordInput(),
          const SizedBox(height: 12),
          _ConfirmPasswordInput(),
          const SizedBox(height: 12),
          _SaveButton(),
        ],
      ),
    );
  }

  void _handleCreateAccessState(
    UserAccessState state,
    BuildContext context,
    CompanyRouteNavigator navigator,
  ) {
    if (state.status.isFailure) {
      if (state.isEmailInUse) {
        showCustomSnackBar(context, 'Email já cadastrado.');
      } else {
        final message = '$genericErrorMessage ${state.errorCode}';
        showCustomSnackBar(context, message);
      }
    } else if (state.status.isSuccess) {
      BlocProvider.of<UserAccessCubit>(context).resetState();
      navigator.pop(true);
    }
  }
}

class _UserNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (UserAccessCubit bloc) => bloc.state.userName.displayError,
    );

    return TextField(
      onChanged: (userName) {
        BlocProvider.of<UserAccessCubit>(context).onUserNameChanged(userName);
      },
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: 'Nome',
        errorText: displayError != null ? 'Campo obrigatório.' : null,
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (UserAccessCubit bloc) => bloc.state.email.displayError,
    );

    return TextField(
      onChanged: (email) {
        BlocProvider.of<UserAccessCubit>(context).onEmailChanged(email);
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
      (UserAccessCubit bloc) => bloc.state.password.displayError,
    );

    final isPasswordEquals = context.select(
      (UserAccessCubit bloc) => bloc.state.isPasswordNotEqual,
    );

    return TextField(
      onChanged: (password) {
        BlocProvider.of<UserAccessCubit>(context).onPasswordChanged(password);
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
      (UserAccessCubit bloc) => bloc.state.confirmPassword.displayError,
    );

    final isPasswordEquals = context.select(
      (UserAccessCubit bloc) => bloc.state.isPasswordNotEqual,
    );

    return TextField(
      onChanged: (password) {
        BlocProvider.of<UserAccessCubit>(
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
      (UserAccessCubit bloc) => bloc.state.status.isInProgress,
    );

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select(
      (UserAccessCubit bloc) => bloc.state.isValid,
    );

    return ElevatedButton(
      onPressed: isValid
          ? () {
              BlocProvider.of<UserAccessCubit>(
                context,
              ).onCreateAccessSubmitted();
            }
          : null,
      child: const Text('Criar Acesso'),
    );
  }
}
