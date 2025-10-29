import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/modules/core/module/core_module.dart';
import 'package:minhaserigrafia/modules/frame/cubit/create_or_update_frame_cubit.dart';
import 'package:minhaserigrafia/modules/frame/cubit/frames_cubit.dart';
import 'package:minhaserigrafia/modules/frame/repository/frame_repository.dart';
import 'package:minhaserigrafia/modules/frame/ui/create_or_update_frame_page.dart';
import 'package:minhaserigrafia/modules/frame/ui/frames_page.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';

import 'cubit/frame_by_id_cubit.dart';
import 'frame_route_navigator.dart';

class FrameModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.addLazySingleton(FrameRouteNavigator.new);
    i.addSingleton(FramesCubit.new);
    i.addSingleton(FrameRepository.new);
    i.addLazySingleton(CreateOrUpdateFrameCubit.new);
    i.addLazySingleton(FrameByIdCubit.new);
  }

  @override
  void routes(r) {
    r.child(
      startRote,
      child: (_) => BlocProvider<FramesCubit>.value(
        value: Modular.get<FramesCubit>(),
        child: const FramesPage(),
      ),
    );
    r.child(
      createOrUpdateFrameRoute,
      child: (_) => MultiBlocProvider(
        providers: [
          BlocProvider<CreateOrUpdateFrameCubit>.value(
            value: Modular.get<CreateOrUpdateFrameCubit>(),
          ),
          BlocProvider<FrameByIdCubit>.value(
            value: Modular.get<FrameByIdCubit>(),
          ),
        ],
        child: CreateOrUpdateFramePage(
          onFrameCreatedOrUpdated: r.args.data["onFrameCreatedOrUpdated"],
          frameId: r.args.data["frameId"],
        ),
      ),
    );
  }
}
