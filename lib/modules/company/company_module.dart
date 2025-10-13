import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/modules/company/ui/company_page.dart';
import 'package:minhaserigrafia/modules/company/ui/create_access_page.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';

import 'company_route_navigator.dart';

class CompanyModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(CompanyRouteNavigator.new);
  }

  @override
  void routes(r) {
    r.child(startRote, child: (_) => const CompanyPage());
    r.child(createAccessRoute, child: (_) => const CreateAccessPage());
  }
}
