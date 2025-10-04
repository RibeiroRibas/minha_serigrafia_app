import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/modules/core/module/core_module.dart';
import 'package:minhaserigrafia/modules/signin/bloc/login_with_email_and_password_bloc.dart';
import 'package:minhaserigrafia/modules/signin/bloc/login_with_google_bloc.dart';
import 'package:minhaserigrafia/modules/signin/repository/custom_auth_repository.dart';
import 'package:minhaserigrafia/modules/signin/repository/firebase_auth_repository.dart';
import 'package:minhaserigrafia/modules/signin/repository/google_auth_repository.dart';
import 'package:minhaserigrafia/modules/signin/service/sign_in_service.dart';
import 'package:minhaserigrafia/modules/signin/sign_in_route_navigator.dart';
import 'package:minhaserigrafia/modules/signin/ui/login_page.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';

class LoginModule extends Module {

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.addLazySingleton(LoginWithEmailAndPasswordBloc.new);
    i.addLazySingleton(LoginWithGoogleBloc.new);
    i.addLazySingleton(SignInService.new);
    i.addLazySingleton(CustomAuthRepository.new);
    i.addSingleton(FirebaseAuthRepository.new);
    i.addLazySingleton(GoogleAuthRepository.new);
    i.addLazySingleton(SignInRouteNavigator.new);
  }

  @override
  void routes(r) {
    r.child(startRote, child: (_) => const LoginPage());
  }
}