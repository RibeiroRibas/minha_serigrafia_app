import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/modules/core/module/core_module.dart';
import 'package:minhaserigrafia/modules/signup/sign_up_route_navigator.dart';
import 'package:minhaserigrafia/modules/signup/ui/complete_sign_up_page.dart';
import 'package:minhaserigrafia/modules/signup/ui/sign_up_page.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';

class SignUpModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.addSingleton(SignUpRouteNavigator.new);
  }

  @override
  void routes(r) {
    r.child(startRote, child: (_) => const SignUpPage());
    r.child(completeSignUpRoute, child: (_) => const CompleteSignInPage());
  }
}
