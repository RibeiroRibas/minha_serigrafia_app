import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/modules/signin/ui/login_page.dart';
import 'package:minhaserigrafia/shared/theme/default_theme.dart';

import 'modules/app/app_module.dart';
import 'modules/signup/ui/create_password_page.dart';
import 'modules/signup/ui/sign_up_page.dart';

void main() {
  runApp(ModularApp(module: AppModule(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Serigrafia',
      theme: defaultTheme,
      home: const LoginPage(),
    );
  }
}
