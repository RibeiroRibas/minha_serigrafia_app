import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/signup/cubit/sign_up_bloc.dart';
import 'package:minhaserigrafia/modules/signup/sign_up_route_navigator.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';

class SignUpStepOneFormComponent extends StatelessWidget {
  const SignUpStepOneFormComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isFailure) {}
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _UserNameInput(),
          const Padding(padding: EdgeInsets.all(12)),
          _CompanyNameInput(),
          const Padding(padding: EdgeInsets.all(12)),
          _CellPhoneInput(),
          const Padding(padding: EdgeInsets.all(12)),
          _NextButton(),
        ],
      ),
    );
  }

  void scaffoldMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

class _UserNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpCubit bloc) => bloc.state.userName.displayError,
    );

    return TextField(
      onChanged: (userName) {
        BlocProvider.of<SignUpCubit>(context).onUserNameChanged(userName);
      },
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: 'Seu Nome',
        errorText: displayError != null ? 'Campo obrigatório.' : null,
      ),
    );
  }
}

class _CompanyNameInput extends StatelessWidget {
  const _CompanyNameInput();

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpCubit bloc) => bloc.state.companyName.displayError,
    );

    return TextField(
      onChanged: (companyName) {

        BlocProvider.of<SignUpCubit>(context).onCompanyNameChanged(companyName);
      },
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: 'Nome da Empresa',
        errorText: displayError != null ? 'Campo obrigatório.' : null,
      ),
    );
  }
}

class _CellPhoneInput extends StatelessWidget {
  const _CellPhoneInput();

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (SignUpCubit bloc) => bloc.state.cellPhone.displayError,
    );

    return TextField(
      onChanged: (cellPhone) {
        BlocProvider.of<SignUpCubit>(context).onCellPhoneChanged(cellPhone);
      },
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: 'Telefone Celular',
        errorText: displayError != null ? 'Número inválido.' : null,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [MaskedInputFormatter('(##) #####-####')],
    );
  }
}

class _NextButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigator = Modular.get<SignUpRouteNavigator>();

    final isValid = context.select(
      (SignUpCubit bloc) => bloc.state.isStepOneValid,
    );

    return ElevatedButton(
      onPressed: isValid ? () {
          navigator.pushNamed('$signUpStepOneRoute$signUpStepTwoRoute');

      } : null,
      child: const Text('Continuar'),
    );
  }
}
