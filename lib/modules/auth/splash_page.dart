import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/modules/auth/auth_route_navigator.dart';
import 'package:minhaserigrafia/modules/auth/cubit/authentication_cubit.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final navigator = Modular.get<AuthRouteNavigator>();

    return Scaffold(
      body: BlocProvider(
        lazy: false,
        create: (context) =>
            Modular.get<AuthenticationCubit>()..onSubscriptionRequested(),
        child: BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
            _handleAuthRedirect(state, navigator);
          },
          child: Padding(
            padding: const EdgeInsets.all(64.0),
            child: Center(child: Image.asset('assets/images/logo.png')),
          ),
        ),
      ),
    );
  }

  void _handleAuthRedirect(AuthenticationState state, AuthRouteNavigator navigator) {
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
