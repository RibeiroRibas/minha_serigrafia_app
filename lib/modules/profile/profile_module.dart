import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/modules/profile/profile_page.dart';
import 'package:minhaserigrafia/modules/profile/profile_route_navigator.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';

class ProfileModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton(ProfileRouteNavigator.new);
  }

  @override
  void routes(r) {
    r.child(startRote, child: (_) => const ProfilePage());
  }
}
