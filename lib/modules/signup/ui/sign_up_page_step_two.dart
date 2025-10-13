import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/modules/signup/cubit/sign_up_bloc.dart';
import 'package:minhaserigrafia/modules/signup/sign_up_route_navigator.dart';
import 'package:minhaserigrafia/modules/signup/ui/sign_up_step_two_form_component.dart';
import 'package:minhaserigrafia/modules/signup/ui/stepper_indicator.dart';
import 'package:minhaserigrafia/shared/ui/back_button_header_component.dart';
import 'package:minhaserigrafia/shared/ui/header_component.dart';
import 'package:minhaserigrafia/shared/ui/primary_container_component.dart';

class SignUpStepTwoPage extends StatefulWidget {
  const SignUpStepTwoPage({super.key});

  @override
  State<SignUpStepTwoPage> createState() => _SignUpStepTwoPageState();
}

class _SignUpStepTwoPageState extends State<SignUpStepTwoPage> {
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
                height: 500,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: BackButtonHeaderComponent(
                            title: 'Cadastre-se',
                            onBackPressed: () => _navigator.pop(),
                          ),
                        ),
                        Expanded(child: StepIndicator(currentStep: 2)),
                      ],
                    ),
                    BlocProvider(
                      create: (BuildContext context) =>
                          Modular.get<SignUpCubit>(),
                      child: SignUpStepTwoFormComponent(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
