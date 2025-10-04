import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/modules/splash/bloc/authentication_bloc.dart';
import 'package:minhaserigrafia/modules/splash/splash_route_navigator.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final navigator = Modular.get<SplashRouteNavigator>();

    return Scaffold(
      body: BlocProvider(
        lazy: false,
        create: (context) =>
            Modular.get<AuthenticationBloc>()
              ..add(AuthenticationSubscriptionRequested()),
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                if (state.isFirstAccess) {
                  navigator.goTo('$signUpRoute$completeSignUpRoute');
                } else {
                  navigator.goTo(homeRoute);
                }
              case AuthenticationStatus.unauthenticated:
                navigator.goTo(signInRoute);
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(64.0),
            child: Center(child: Image.asset('assets/images/logo.png')),
          ),
        ),
      ),
    );
  }
}
