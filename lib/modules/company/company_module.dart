import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/modules/company/cubit/company_statistics_cubit.dart';
import 'package:minhaserigrafia/modules/company/cubit/user_access_cubit.dart';
import 'package:minhaserigrafia/modules/company/repository/company_repository.dart';
import 'package:minhaserigrafia/modules/company/ui/company_page.dart';
import 'package:minhaserigrafia/modules/company/ui/create_access_page.dart';
import 'package:minhaserigrafia/modules/core/module/core_module.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';

import 'company_route_navigator.dart';
import 'cubit/company_info_cubit.dart';

class CompanyModule extends Module {

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.addLazySingleton(CompanyRouteNavigator.new);
    i.addLazySingleton(UserAccessCubit.new);
    i.addSingleton(CompanyRepository.new);
    i.addSingleton(CompanyInfoCubit.new);
    i.addSingleton(CompanyStatisticsCubit.new);
  }

  @override
  void routes(r) {
    r.child(startRote, child: (_) => const CompanyPage());
    r.child(createAccessRoute, child: (_) => const CreateAccessPage());
  }
}
