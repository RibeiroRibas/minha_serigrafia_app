import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/modules/core/module/core_module.dart';
import 'package:minhaserigrafia/modules/signin/repository/custom_auth_repository.dart';
import 'package:minhaserigrafia/modules/signin/repository/firebase_auth_repository.dart';
import 'package:minhaserigrafia/modules/auth/cubit/authentication_cubit.dart';
import 'package:minhaserigrafia/modules/auth/splash_page.dart';
import 'package:minhaserigrafia/modules/auth/auth_route_navigator.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';

class AuthModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.addSingleton(FirebaseAuthRepository.new);
    i.addSingleton(CustomAuthRepository.new);
    i.addSingleton(AuthenticationCubit.new);
    i.addLazySingleton(AuthRouteNavigator.new);
  }

  @override
  void routes(r) {
    r.child(startRote, child: (_) => const SplashPage());
  }
}
