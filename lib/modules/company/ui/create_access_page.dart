import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/modules/company/company_route_navigator.dart';
import 'package:minhaserigrafia/modules/company/cubit/user_access_cubit.dart';
import 'package:minhaserigrafia/modules/company/ui/create_access_component.dart';
import 'package:minhaserigrafia/shared/ui/back_button_header_component.dart';

class CreateAccessPage extends StatefulWidget {
  const CreateAccessPage({super.key});

  @override
  State<CreateAccessPage> createState() => _CreateAccessPageState();
}

class _CreateAccessPageState extends State<CreateAccessPage> {
  final _navigator = Modular.get<CompanyRouteNavigator>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 24),
                BackButtonHeaderComponent(
                  title: 'Incluir acesso',
                  onBackPressed: () => _navigator.pop(),
                ),
                SizedBox(height: 36),
                BlocProvider(
                  create: (BuildContext context) =>
                      Modular.get<UserAccessCubit>(),
                  child: CreateAccessComponent(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
