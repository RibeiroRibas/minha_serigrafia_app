import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/modules/core/module/core_module.dart';
import 'package:minhaserigrafia/modules/customer/cubit/create_or_update_customer_cubit.dart';
import 'package:minhaserigrafia/modules/customer/cubit/customer_by_id_cubit.dart';
import 'package:minhaserigrafia/modules/customer/cubit/customers_cubit.dart';
import 'package:minhaserigrafia/modules/customer/customer_route_navigator.dart';
import 'package:minhaserigrafia/modules/customer/repository/customer_repository.dart';
import 'package:minhaserigrafia/modules/customer/ui/create_or_update_customer_page.dart';
import 'package:minhaserigrafia/modules/customer/ui/customers_page.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';

class CustomerModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.addLazySingleton(CustomerRouteNavigator.new);
    i.addSingleton(CustomersCubit.new);
    i.addSingleton(CustomerRepository.new);
    i.addLazySingleton(CreateOrUpdateCustomerCubit.new);
    i.addLazySingleton(CustomerByIdCubit.new);
  }

  @override
  void routes(r) {
    r.child(
      startRote,
      child: (_) => BlocProvider<CustomersCubit>.value(
        value: Modular.get<CustomersCubit>(),
        child: CustomersPage(
          onCustomerSelected: r.args.data["onCustomerSelected"],
        ),
      ),
    );
    r.child(
      createOrUpdateCustomerRoute,
      child: (_) => MultiBlocProvider(
        providers: [
          BlocProvider<CreateOrUpdateCustomerCubit>.value(
            value: Modular.get<CreateOrUpdateCustomerCubit>(),
          ),
          BlocProvider<CustomerByIdCubit>.value(
            value: Modular.get<CustomerByIdCubit>(),
          ),
        ],
        child: CreateOrUpdateCustomerPage(
          onCustomerCreatedOrUpdated: r.args.data["onCustomerCreatedOrUpdated"],
          customerId: r.args.data["customerId"],
        ),
      ),
    );
  }
}
