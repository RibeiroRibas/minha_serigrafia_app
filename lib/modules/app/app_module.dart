import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/modules/home/home_module.dart';
import 'package:minhaserigrafia/modules/signin/login_module.dart';
import 'package:minhaserigrafia/modules/signup/sign_up_module.dart';
import 'package:minhaserigrafia/modules/splash/splash_module.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.module(startRote, module: SplashModule());
    r.module(signInRoute, module: LoginModule());
    r.module(homeRoute, module: HomeModule());
    r.module(signUpRoute, module: SignUpModule());
  }
}
