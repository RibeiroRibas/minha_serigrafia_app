import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/customer/cubit/create_or_update_customer_cubit.dart';
import 'package:minhaserigrafia/modules/customer/cubit/customer_by_id_cubit.dart';
import 'package:minhaserigrafia/modules/customer/customer_route_navigator.dart';
import 'package:minhaserigrafia/modules/customer/model/customer_model.dart';
import 'package:minhaserigrafia/modules/signup/ui/generic_error_component.dart';
import 'package:minhaserigrafia/shared/error_messages.dart' as error_message;
import 'package:minhaserigrafia/shared/ui/back_button_header_component.dart';
import 'package:minhaserigrafia/shared/ui/custom_snack_bar.dart';

import 'create_or_update_customer_component.dart';

class CreateOrUpdateCustomerPage extends StatefulWidget {
  final VoidCallback onCustomerCreatedOrUpdated;
  final int? customerId;

  const CreateOrUpdateCustomerPage({
    super.key,
    required this.onCustomerCreatedOrUpdated,
    this.customerId,
  });

  @override
  State<CreateOrUpdateCustomerPage> createState() =>
      _CreateOrUpdateCustomerPageState();
}

class _CreateOrUpdateCustomerPageState
    extends State<CreateOrUpdateCustomerPage> {
  final CustomerModel customerModel = CustomerModel();

  @override
  void initState() {
    super.initState();
    if (widget.customerId != null) {
      BlocProvider.of<CustomerByIdCubit>(
        context,
      ).onGetCustomerByIdSubmitted(customerId: widget.customerId!);
    } else {
      BlocProvider.of<CustomerByIdCubit>(context).resetState();
      BlocProvider.of<CreateOrUpdateCustomerCubit>(context).resetState();
    }
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Modular.get<CustomerRouteNavigator>();

    return BlocListener<
      CreateOrUpdateCustomerCubit,
      CreateOrUpdateCustomerState
    >(
      listener: (context, state) =>
          _handleCreateOrUpdateCustomerState(state, context, navigator),
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
                    title: widget.customerId != null
                        ? 'Atualizar cliente'
                        : 'Adicionar cliente',
                    onBackPressed: () => navigator.pop(),
                  ),
                  SizedBox(height: 36),
                  BlocBuilder<CustomerByIdCubit, CustomerByIdState>(
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
                          onRetry: () =>
                              BlocProvider.of<CustomerByIdCubit>(
                                context,
                              ).onGetCustomerByIdSubmitted(
                                customerId: widget.customerId!,
                              ),
                          errorCode: state.errorCode,
                        );
                      } else {
                        return CreateOrUpdateCustomerComponent(
                          customerModel: state.status.isSuccess
                              ? state.customerModel
                              : CustomerModel(),
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

  void _handleCreateOrUpdateCustomerState(
    CreateOrUpdateCustomerState state,
    BuildContext context,
    CustomerRouteNavigator navigator,
  ) {
    if (state.status.isFailure && !state.customerNameInUse) {
      final message = error_message.fromErrorCode(state.errorCode);
      showCustomSnackBar(context, message);
    } else if (state.status.isSuccess) {
      widget.onCustomerCreatedOrUpdated.call();
      navigator.pop();
    }
  }
}
