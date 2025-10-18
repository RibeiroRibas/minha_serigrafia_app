import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/company/company_route_navigator.dart';
import 'package:minhaserigrafia/modules/company/cubit/create_access_cubit.dart';
import 'package:minhaserigrafia/modules/company/ui/create_access_component.dart';
import 'package:minhaserigrafia/shared/error_messages.dart' as error_message;
import 'package:minhaserigrafia/shared/ui/back_button_header_component.dart';
import 'package:minhaserigrafia/shared/ui/custom_snack_bar.dart';

class CreateAccessPage extends StatelessWidget {
  final VoidCallback onAccessCreated;

  const CreateAccessPage({super.key, required this.onAccessCreated});

  @override
  Widget build(BuildContext context) {
    final navigator = Modular.get<CompanyRouteNavigator>();

    return BlocListener<CreateAccessCubit, CreateAccessState>(
      listener: (context, state) =>
          _handleCreateAccessState(state, context, navigator),
      child: SafeArea(
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
                    onBackPressed: () => navigator.pop(),
                  ),
                  SizedBox(height: 36),
                  CreateAccessComponent(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleCreateAccessState(
    CreateAccessState state,
    BuildContext context,
    CompanyRouteNavigator navigator,
  ) {
    if (state.status.isFailure) {
      final message = error_message.fromErrorCode(state.errorCode);
      showCustomSnackBar(context, message);
    } else if (state.status.isSuccess) {
      BlocProvider.of<CreateAccessCubit>(context).resetState();
      onAccessCreated.call();
      navigator.pop();
    }
  }
}
