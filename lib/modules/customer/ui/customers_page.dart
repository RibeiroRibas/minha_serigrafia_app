import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/customer/cubit/customers_cubit.dart';
import 'package:minhaserigrafia/modules/customer/customer_route_navigator.dart';
import 'package:minhaserigrafia/modules/signup/ui/generic_error_component.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';
import 'package:minhaserigrafia/shared/ui/custom_dialog.dart' as custom_dialog;

import 'customer_item_component.dart';

class CustomersPage extends StatefulWidget {
  final Function(int, String)? onCustomerSelected;

  const CustomersPage({super.key, this.onCustomerSelected});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  final _navigator = Modular.get<CustomerRouteNavigator>();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CustomersCubit>(context).onGetCustomerSubmitted();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 64,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: Center(
              child: Text(
                "Clientes",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(64),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: SizedBox(
                height: 44,
                child: TextFormField(
                  onChanged: (String value) {
                    _debounce?.cancel();
                    _debounce = Timer(const Duration(milliseconds: 500), () {
                      if (!mounted) return;
                      BlocProvider.of<CustomersCubit>(
                        context,
                      ).onGetCustomerSubmitted(customerName: value);
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                    ),
                    hintText: 'Pesquisar cliente...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<CustomersCubit, CustomersState>(
            builder: (context, state) {
              if (state.status.isSuccess) {
                return state.customers.isNotEmpty
                    ? ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 12);
                        },
                        shrinkWrap: true,
                        itemCount: state.customers.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            child: CustomerItemComponent(
                              customerModel: state.customers[index],
                            ),
                            onTap: () => {
                              if (widget.onCustomerSelected != null)
                                {
                                  widget.onCustomerSelected!(
                                    state.customers[index].id,
                                    state.customers[index].name,
                                  ),
                                  _navigator.pop(),
                                }
                              else
                                _navigator.pushNamed(
                                  '$customerRoute$createOrUpdateCustomerRoute',
                                  arguments: {
                                    "customerId": state.customers[index].id,
                                    "onCustomerCreatedOrUpdated": () {
                                      BlocProvider.of<CustomersCubit>(
                                        context,
                                      ).onGetCustomerSubmitted();
                                    },
                                  },
                                ),
                            },
                            onLongPress: () => custom_dialog.confirmAction(
                              context: context,
                              message:
                                  'Tem certeza que deseja excluir este cliente?',
                              onConfirm: () {
                                BlocProvider.of<CustomersCubit>(
                                  context,
                                ).onDeleteCustomerSubmitted(
                                  customerId: state.customers[index].id,
                                );
                              },
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          'Nenhum cliente encontrado.\n Adicione novos clientes\npara começar a gerenciá-los.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
              }
              if (state.status.isFailure) {
                return GenericErrorComponent(
                  onRetry: () => BlocProvider.of<CustomersCubit>(
                    context,
                  ).onGetCustomerSubmitted(),
                  errorCode: state.errorCode,
                );
              }
              return Center(child: const CircularProgressIndicator());
            },
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () => _navigator.pushNamed(
              '$customerRoute$createOrUpdateCustomerRoute',
              arguments: {
                "onCustomerCreatedOrUpdated": () {
                  BlocProvider.of<CustomersCubit>(
                    context,
                  ).onGetCustomerSubmitted();
                },
              },
            ),
            child: const Text('Adicionar'),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
