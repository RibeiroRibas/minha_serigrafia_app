import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/modules/company/cubit/company_statistics_cubit.dart';
import 'package:minhaserigrafia/modules/company/cubit/create_access_cubit.dart';
import 'package:minhaserigrafia/modules/company/cubit/delete_company_cubit.dart';
import 'package:minhaserigrafia/modules/company/cubit/remove_access_cubit.dart';
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
    i.addLazySingleton(CreateAccessCubit.new);
    i.addSingleton(CompanyRepository.new);
    i.addSingleton(CompanyInfoCubit.new);
    i.addSingleton(CompanyStatisticsCubit.new);
    i.addSingleton(RemoveAccessCubit.new);
    i.addSingleton(DeleteCompanyCubit.new);
  }

  @override
  void routes(r) {
    r.child(
      startRote,
      child: (_) => MultiBlocProvider(
        providers: [
          BlocProvider<CompanyInfoCubit>.value(
            value: Modular.get<CompanyInfoCubit>(),
          ),
          BlocProvider<RemoveAccessCubit>.value(
            value: Modular.get<RemoveAccessCubit>(),
          ),
          BlocProvider<DeleteCompanyCubit>.value(
            value: Modular.get<DeleteCompanyCubit>(),
          ),
        ],
        child: const CompanyPage(),
      ),
    );
    r.child(
      createAccessRoute,
      child: (_) => BlocProvider<CreateAccessCubit>.value(
        value: Modular.get<CreateAccessCubit>(),
        child: CreateAccessPage(
          onAccessCreated: r.args.data["onAccessCreated"],
        ),
      ),
    );
  }
}
