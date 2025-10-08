import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/signin/cubit/login_with_email_and_password_cubit.dart';
import 'package:minhaserigrafia/modules/signin/cubit/login_with_google_cubit.dart';
import 'package:minhaserigrafia/modules/signin/sign_in_route_navigator.dart';
import 'package:minhaserigrafia/modules/signin/ui/login_form_component.dart';
import 'package:minhaserigrafia/shared/messages.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';
import 'package:minhaserigrafia/shared/ui/custom_snack_bar.dart';
import 'package:minhaserigrafia/shared/ui/header_component.dart';
import 'package:minhaserigrafia/shared/ui/primary_container_component.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final navigator = Modular.get<SignInRouteNavigator>();

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
                body: BlocProvider(
                  create: (BuildContext context) =>
                      Modular.get<LoginWithEmailAndPasswordCubit>(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      LoginFormComponent(),
                      _SignUp(),
                      Text('Ou'),
                      BlocProvider(
                        create: (BuildContext context) =>
                            Modular.get<LoginWithGoogleCubit>(),
                        child:
                            BlocListener<
                              LoginWithGoogleCubit,
                              LoginWithGoogleState
                            >(
                              listener: (context, state) =>
                                  _handleLoginWithGoogleState(state, context),
                              child: _LoginWithGoogle(),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLoginWithGoogleState(
    LoginWithGoogleState state,
    BuildContext context,
  ) {
    if (state.status.isSuccess) {
      if (state.isFirstAccess) {
        navigator.goTo('$signUpStepOneRoute$completeSignUpRoute');
      } else {
        navigator.goTo(homeRoute);
      }
    } else if (state.status.isFailure) {
      String message = '$genericErrorMessage ${state.errorCode}';
      showCustomSnackBar(context, message);
    }
  }
}

class _SignUp extends StatelessWidget {
  const _SignUp();

  @override
  Widget build(BuildContext context) {
    final navigator = Modular.get<SignInRouteNavigator>();

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(fontSize: 16),
        children: [
          TextSpan(
            text: 'Ainda não possui uma conta?\n',
            style: TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: 'Cadastre-se!',
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => navigator.goTo(signUpStepOneRoute),
          ),
        ],
      ),
    );
  }
}

class _LoginWithGoogle extends StatelessWidget {
  const _LoginWithGoogle();

  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (LoginWithGoogleCubit bloc) => bloc.state.status.isInProgress,
    );

    if (isInProgress) return const CircularProgressIndicator();

    return OutlinedButton.icon(
      icon: Image.asset(
        'assets/images/google-color.png',
        height: 24,
        width: 24,
      ),
      label: Text('Continue com Google', style: TextStyle(fontSize: 16)),
      onPressed: () => BlocProvider.of<LoginWithGoogleCubit>(
        context,
      ).onSignInWithGoogleSubmitted(),
    );
  }
}
