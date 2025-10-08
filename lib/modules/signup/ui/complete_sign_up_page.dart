import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/signup/cubit/sign_up_bloc.dart';
import 'package:minhaserigrafia/modules/signup/sign_up_route_navigator.dart';
import 'package:minhaserigrafia/shared/messages.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';
import 'package:minhaserigrafia/shared/ui/back_button_header_component.dart';
import 'package:minhaserigrafia/shared/ui/custom_snack_bar.dart';
import 'package:minhaserigrafia/shared/ui/header_component.dart';
import 'package:minhaserigrafia/shared/ui/primary_container_component.dart';

class CompleteSignInPage extends StatefulWidget {
  const CompleteSignInPage({super.key});

  @override
  State<CompleteSignInPage> createState() => _CompleteSignInPageState();
}

class _CompleteSignInPageState extends State<CompleteSignInPage> {
  final _navigator = Modular.get<SignUpRouteNavigator>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HeaderComponent(),
              PrimaryContainerComponent(
                height: 400,
                body: Form(
                  child: BlocProvider(
                    create: (BuildContext context) =>
                        Modular.get<SignUpCubit>(),
                    child: BlocListener<SignUpCubit, SignUpState>(
                      listener: (context, state) =>
                          _handleCompleteSignUpState(state, context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          BackButtonHeaderComponent(
                            title: 'Complete seu Cadastro',
                            onBackPressed: () =>
                                _navigator.goTo('$signInRoute/'),
                          ),
                          _CompanyNameInput(),
                          _CellPhoneInput(),
                          _SaveButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleCompleteSignUpState(SignUpState state, BuildContext context) {
    if (state.status.isFailure) {
      String message = '$genericErrorMessage ${state.errorCode}';
      showCustomSnackBar(context, message);
    } else if (state.status.isSuccess) {
      _navigator.goTo(homeRoute);
    }
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

class _SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (SignUpCubit bloc) => bloc.state.status.isInProgress,
    );

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select(
      (SignUpCubit bloc) => bloc.state.isCompleteSignUpValid,
    );

    return ElevatedButton(
      onPressed: isValid
          ? () {
              BlocProvider.of<SignUpCubit>(context).onCompleteSignUpSubmitted();
            }
          : null,
      child: const Text('Concluir'),
    );
  }
}
