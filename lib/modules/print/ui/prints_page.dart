import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/print/cubit/prints_cubit.dart';
import 'package:minhaserigrafia/modules/print/print_route_navigator.dart';
import 'package:minhaserigrafia/modules/signup/ui/generic_error_component.dart';
import 'package:minhaserigrafia/shared/model/last_usage_order_enum.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';
import 'package:minhaserigrafia/shared/ui/custom_dialog.dart' as custom_dialog;

import 'print_item_component.dart';

class PrintsPage extends StatefulWidget {
  const PrintsPage({super.key});

  @override
  State<PrintsPage> createState() => _PrintsPageState();
}

class _PrintsPageState extends State<PrintsPage> {
  final _navigator = Modular.get<PrintRouteNavigator>();
  LastUsageOrder? selected;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PrintsCubit>(context).onGetPrintsSubmitted();
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
                "Estampas",
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
                      BlocProvider.of<PrintsCubit>(
                        context,
                      ).onGetPrintsSubmitted(inputFilter: value);
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
                    ),
                    suffixIcon: IconButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        custom_dialog.showLastUsageOrderDialog(
                          setState: (LastUsageOrder? selectedOrder) {
                            setState(() {
                              selected = selectedOrder;
                            });
                            BlocProvider.of<PrintsCubit>(
                              context,
                            ).onGetPrintsSubmitted(
                              lastUsageOrderFilter: selectedOrder?.name,
                            );
                            _navigator.pop();
                          },
                          context: context,
                          selected: selected,
                        );
                      },
                      icon: Icon(Icons.filter_list),
                    ),
                    hintText: 'Pesquisar estampa...',
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
          child: BlocBuilder<PrintsCubit, PrintsState>(
            builder: (context, state) {
              if (state.status.isSuccess) {
                return state.prints.isNotEmpty
                    ? ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 12);
                        },
                        shrinkWrap: true,
                        itemCount: state.prints.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            child: PrintItemComponent(
                              printModel: state.prints[index],
                            ),
                            onTap: () => _navigator.pushNamed(
                              '$printRoute$createOrUpdatePrintRoute',
                              arguments: {
                                "printId": state.prints[index].id,
                                "onPrintCreatedOrUpdated": () {
                                  BlocProvider.of<PrintsCubit>(
                                    context,
                                  ).onGetPrintsSubmitted();
                                },
                              },
                            ),
                            onLongPress: () => custom_dialog.confirmAction(
                              context: context,
                              message:
                                  'Tem certeza que deseja excluir esta estampa?',
                              onConfirm: () {
                                BlocProvider.of<PrintsCubit>(
                                  context,
                                ).onDeletePrintSubmitted(
                                  printId: state.prints[index].id,
                                );
                              },
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          'Nenhuma estampa encontrada.\n Adicione novas estampas\npara começar a gerenciá-las.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
              }
              if (state.status.isFailure) {
                return GenericErrorComponent(
                  onRetry: () => BlocProvider.of<PrintsCubit>(
                    context,
                  ).onGetPrintsSubmitted(),
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
              '$printRoute$createOrUpdatePrintRoute',
              arguments: {
                "onPrintCreatedOrUpdated": () {
                  BlocProvider.of<PrintsCubit>(context).onGetPrintsSubmitted();
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
