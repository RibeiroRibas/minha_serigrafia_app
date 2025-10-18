import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minhaserigrafia/modules/auth/auth_route_navigator.dart';
import 'package:minhaserigrafia/modules/auth/cubit/authentication_cubit.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthenticationCubit>(context).onSubscriptionRequested();
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Modular.get<AuthRouteNavigator>();

    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        _handleAuthRedirect(state, navigator);
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(64.0),
          child: Center(
            child: SvgPicture.asset(
              'assets/images/logo_white.svg',
              width: 100,
              semanticsLabel: 'Minha imagem SVG',
            ),
          ),
        ),
      ),
    );
  }

  void _handleAuthRedirect(
    AuthenticationState state,
    AuthRouteNavigator navigator,
  ) {
    switch (state.status) {
      case AuthenticationStatus.authenticated:
        if (state.isFirstAccess) {
          navigator.goTo('$signUpStepOneRoute$completeSignUpRoute');
        } else {
          navigator.goTo(homeRoute);
        }
      case AuthenticationStatus.unauthenticated:
        navigator.goTo(signInRoute);
      case AuthenticationStatus.unknown:
        navigator.goTo(signInRoute);
    }
  }


}
