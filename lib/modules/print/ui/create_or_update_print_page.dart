import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/print/model/print_model.dart';
import 'package:minhaserigrafia/modules/print/cubit/create_or_update_print_cubit.dart';
import 'package:minhaserigrafia/modules/print/cubit/print_by_id_cubit.dart';
import 'package:minhaserigrafia/modules/print/print_route_navigator.dart';
import 'package:minhaserigrafia/modules/signup/ui/generic_error_component.dart';
import 'package:minhaserigrafia/shared/error_messages.dart' as error_message;
import 'package:minhaserigrafia/shared/ui/back_button_header_component.dart';
import 'package:minhaserigrafia/shared/ui/custom_snack_bar.dart';

import 'create_or_update_print_component.dart';

class CreateOrUpdatePrintPage extends StatefulWidget {
  final VoidCallback onPrintCreatedOrUpdated;
  final int? printId;

  const CreateOrUpdatePrintPage({
    super.key,
    required this.onPrintCreatedOrUpdated,
    this.printId,
  });

  @override
  State<CreateOrUpdatePrintPage> createState() =>
      _CreateOrUpdatePrintPageState();
}

class _CreateOrUpdatePrintPageState extends State<CreateOrUpdatePrintPage> {
  final PrintModel printModel = PrintModel();

  @override
  void initState() {
    super.initState();
    if (widget.printId != null) {
      BlocProvider.of<PrintByIdCubit>(
        context,
      ).onGetPrintByIdSubmitted(printId: widget.printId!);
    } else {
      BlocProvider.of<PrintByIdCubit>(context).resetState();
      BlocProvider.of<CreateOrUpdatePrintCubit>(context).resetState();
    }
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Modular.get<PrintRouteNavigator>();

    return BlocListener<CreateOrUpdatePrintCubit, CreateOrUpdatePrintState>(
      listener: (context, state) =>
          _handleCreateOrUpdatePrintState(state, context, navigator),
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
                    title: widget.printId != null
                        ? 'Atualizar estampa'
                        : 'Adicionar estampa',
                    onBackPressed: () => navigator.pop(),
                  ),
                  SizedBox(height: 36),
                  BlocBuilder<PrintByIdCubit, PrintByIdState>(
                    builder: (context, state) {
                      if (state.status.isInProgress) {
                        return CircularProgressIndicator();
                      } else if (state.status.isFailure) {
                        final message = error_message.fromErrorCode(
                          state.errorCode,
                        );
                        return Text(message);
                      } else if (state.status.isFailure) {
                        return GenericErrorComponent(
                          onRetry: () => BlocProvider.of<PrintByIdCubit>(
                            context,
                          ).onGetPrintByIdSubmitted(printId: widget.printId!),
                          errorCode: state.errorCode,
                        );
                      } else {
                        return CreateOrUpdatePrintComponent(
                          printModel: state.status.isSuccess
                              ? state.printModel
                              : PrintModel(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleCreateOrUpdatePrintState(
    CreateOrUpdatePrintState state,
    BuildContext context,
    PrintRouteNavigator navigator,
  ) {
    if (state.status.isFailure && !state.printNameInUse) {
      final message = error_message.fromErrorCode(state.errorCode);
      showCustomSnackBar(context, message);
    } else if (state.status.isSuccess) {
      widget.onPrintCreatedOrUpdated.call();
      navigator.pop();
    }
  }
}
