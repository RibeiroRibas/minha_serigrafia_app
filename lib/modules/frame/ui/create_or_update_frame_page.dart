import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/frame/cubit/create_or_update_frame_cubit.dart';
import 'package:minhaserigrafia/modules/frame/cubit/frame_by_id_cubit.dart';
import 'package:minhaserigrafia/modules/frame/frame_route_navigator.dart';
import 'package:minhaserigrafia/modules/frame/model/frame_model.dart';
import 'package:minhaserigrafia/modules/signup/ui/generic_error_component.dart';
import 'package:minhaserigrafia/shared/error_messages.dart' as error_message;
import 'package:minhaserigrafia/shared/ui/back_button_header_component.dart';
import 'package:minhaserigrafia/shared/ui/custom_snack_bar.dart';

import 'create_or_update_frame_component.dart';

class CreateOrUpdateFramePage extends StatefulWidget {
  final VoidCallback onFrameCreatedOrUpdated;
  final int? frameId;

  const CreateOrUpdateFramePage({
    super.key,
    required this.onFrameCreatedOrUpdated,
    this.frameId,
  });

  @override
  State<CreateOrUpdateFramePage> createState() =>
      _CreateOrUpdateFramePageState();
}

class _CreateOrUpdateFramePageState extends State<CreateOrUpdateFramePage> {
  final FrameModel frameModel = FrameModel();

  @override
  void initState() {
    super.initState();
    if (widget.frameId != null) {
      BlocProvider.of<FrameByIdCubit>(
        context,
      ).onGetFrameByIdSubmitted(frameId: widget.frameId!);
    } else {
      BlocProvider.of<FrameByIdCubit>(context).resetState();
      BlocProvider.of<CreateOrUpdateFrameCubit>(context).resetState();
    }
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Modular.get<FrameRouteNavigator>();

    return BlocListener<CreateOrUpdateFrameCubit, CreateOrUpdateFrameState>(
      listener: (context, state) =>
          _handleCreateOrUpdateFrameState(state, context, navigator),
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
                    title: widget.frameId != null
                        ? 'Atualizar matriz'
                        : 'Adicionar matriz',
                    onBackPressed: () => navigator.pop(),
                  ),
                  SizedBox(height: 36),
                  BlocBuilder<FrameByIdCubit, FrameByIdState>(
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
                          onRetry: () => BlocProvider.of<FrameByIdCubit>(
                            context,
                          ).onGetFrameByIdSubmitted(frameId: widget.frameId!),
                          errorCode: state.errorCode,
                        );
                      } else {
                        return CreateOrUpdateFrameComponent(
                          frameModel: state.status.isSuccess
                              ? state.frameModel
                              : FrameModel(),
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

  void _handleCreateOrUpdateFrameState(
    CreateOrUpdateFrameState state,
    BuildContext context,
    FrameRouteNavigator navigator,
  ) {
    if (state.status.isFailure && !state.frameIdentifierInUse) {
      final message = error_message.fromErrorCode(state.errorCode);
      showCustomSnackBar(context, message);
    } else if (state.status.isSuccess) {
      widget.onFrameCreatedOrUpdated.call();
      navigator.pop();
    }
  }
}
