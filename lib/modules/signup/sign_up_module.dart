import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/modules/core/module/core_module.dart';
import 'package:minhaserigrafia/modules/signin/repository/custom_auth_repository.dart';
import 'package:minhaserigrafia/modules/signin/repository/firebase_auth_repository.dart';
import 'package:minhaserigrafia/modules/signin/repository/google_auth_repository.dart';
import 'package:minhaserigrafia/modules/signin/service/sign_in_service.dart';
import 'package:minhaserigrafia/modules/signup/cubit/sign_up_bloc.dart';
import 'package:minhaserigrafia/modules/signup/repository/sign_up_repository.dart';
import 'package:minhaserigrafia/modules/signup/sign_up_route_navigator.dart';
import 'package:minhaserigrafia/modules/signup/ui/complete_sign_up_page.dart';
import 'package:minhaserigrafia/modules/signup/ui/sign_up_page_step_one.dart';
import 'package:minhaserigrafia/modules/signup/ui/sign_up_page_step_two.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';

class SignUpModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(i) {
    i.addLazySingleton(SignUpRepository.new);
    i.addLazySingleton(CustomAuthRepository.new);
    i.addLazySingleton(FirebaseAuthRepository.new);
    i.addLazySingleton(GoogleAuthRepository.new);
    i.addLazySingleton(SignInService.new);
    i.addLazySingleton(SignUpCubit.new);
    i.addLazySingleton(SignUpRouteNavigator.new);
  }

  @override
  void routes(r) {
    r.child(startRote, child: (_) => const SignUpStepOnePage());
    r.child(signUpStepTwoRoute, child: (_) => const SignUpStepTwoPage());
    r.child(completeSignUpRoute, child: (_) => const CompleteSignInPage());
  }
}
