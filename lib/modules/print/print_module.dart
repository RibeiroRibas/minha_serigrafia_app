import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/modules/core/module/core_module.dart';
import 'package:minhaserigrafia/modules/print/cubit/create_or_update_print_cubit.dart';
import 'package:minhaserigrafia/modules/print/cubit/print_by_id_cubit.dart';
import 'package:minhaserigrafia/modules/print/cubit/prints_cubit.dart';
import 'package:minhaserigrafia/modules/print/print_route_navigator.dart';
import 'package:minhaserigrafia/modules/print/repository/print_repository.dart';
import 'package:minhaserigrafia/modules/print/ui/color_picker_page.dart';
import 'package:minhaserigrafia/modules/print/ui/create_or_update_print_page.dart';
import 'package:minhaserigrafia/modules/print/ui/prints_page.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';

class PrintModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.addLazySingleton(PrintRouteNavigator.new);
    i.addSingleton(PrintsCubit.new);
    i.addSingleton(PrintRepository.new);
    i.addLazySingleton(CreateOrUpdatePrintCubit.new);
    i.addLazySingleton(PrintByIdCubit.new);
  }

  @override
  void routes(r) {
    r.child(
      startRote,
      child: (_) => BlocProvider<PrintsCubit>.value(
        value: Modular.get<PrintsCubit>(),
        child: const PrintsPage(),
      ),
    );
    r.child(
      createOrUpdatePrintRoute,
      child: (_) => MultiBlocProvider(
        providers: [
          BlocProvider<CreateOrUpdatePrintCubit>.value(
            value: Modular.get<CreateOrUpdatePrintCubit>(),
          ),
          BlocProvider<PrintByIdCubit>.value(
            value: Modular.get<PrintByIdCubit>(),
          ),
        ],
        child: CreateOrUpdatePrintPage(
          onPrintCreatedOrUpdated: r.args.data["onPrintCreatedOrUpdated"],
          printId: r.args.data["printId"],
        ),
      ),
    );
    r.child(
      selectColorRoute,
      child: (_) => ColorPickerPage(
        onColorSelected: r.args.data["onColorSelected"],
        initialColorHex: r.args.data["initialColorHex"],
      ),
    );
  }
}
