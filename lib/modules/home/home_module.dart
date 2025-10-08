import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/modules/core/module/core_module.dart';
import 'package:minhaserigrafia/modules/home/ui/home_page.dart';
import 'package:minhaserigrafia/modules/signin/repository/firebase_auth_repository.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';

import 'home_route_navigator.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.addLazySingleton(HomeRouteNavigator.new);
    i.addSingleton(FirebaseAuthRepository.new);
  }

  @override
  void routes(r) {
    r.child(startRote, child: (_) => const HomePage());
  }
}
