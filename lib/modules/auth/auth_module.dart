import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/modules/signin/login_module.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';

class AuthModule extends Module {

  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.module(startRote, module: AuthModule());
    r.module(signInRoute, module: LoginModule());
  }
}