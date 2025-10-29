import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/modules/auth/auth_module.dart';
import 'package:minhaserigrafia/modules/company/company_module.dart';
import 'package:minhaserigrafia/modules/frame/frame_module.dart';
import 'package:minhaserigrafia/modules/home/home_module.dart';
import 'package:minhaserigrafia/modules/profile/profile_module.dart';
import 'package:minhaserigrafia/modules/signin/login_module.dart';
import 'package:minhaserigrafia/modules/signup/sign_up_module.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.module(startRote, module: AuthModule());
    r.module(signInRoute, module: LoginModule());
    r.module(homeRoute, module: HomeModule());
    r.module(signUpStepOneRoute, module: SignUpModule());
    r.module(companyRoute, module: CompanyModule());
    r.module(profileRoute, module: ProfileModule());
    r.module(frameRoute, module: FrameModule());
  }
}
