import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/frame/cubit/frames_cubit.dart';
import 'package:minhaserigrafia/modules/frame/frame_route_navigator.dart';
import 'package:minhaserigrafia/modules/signup/ui/generic_error_component.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';
import 'package:minhaserigrafia/shared/ui/custom_dialog.dart' as custom_dialog;

import 'frame_item_component.dart';

enum LastUsageOrder { desc, asc }

class FramesPage extends StatefulWidget {
  const FramesPage({super.key});

  @override
  State<FramesPage> createState() => _FramesPageState();
}

class _FramesPageState extends State<FramesPage> {
  final _navigator = Modular.get<FrameRouteNavigator>();
  LastUsageOrder? selected;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FramesCubit>(context).onGetFramesSubmitted();
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
                "Matrizes",
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
                      BlocProvider.of<FramesCubit>(
                        context,
                      ).onGetFramesSubmitted(inputFilter: value);
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
                        showLastUsageOrderDialog();
                      },
                      icon: Icon(Icons.filter_list),
                    ),
                    hintText: 'Pesquisar matriz...',
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
          child: BlocBuilder<FramesCubit, FramesState>(
            builder: (context, state) {
              if (state.status.isSuccess) {
                return state.frames.isNotEmpty
                    ? ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 12);
                        },
                        shrinkWrap: true,
                        itemCount: state.frames.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            child: FrameItemComponent(
                              frameModel: state.frames[index],
                            ),
                            onTap: () => _navigator.pushNamed(
                              '$frameRoute$createOrUpdateFrameRoute',
                              arguments: {
                                "frameId": state.frames[index].id,
                                "onFrameCreatedOrUpdated": () {
                                  BlocProvider.of<FramesCubit>(
                                    context,
                                  ).onGetFramesSubmitted();
                                },
                              },
                            ),
                            onLongPress: () => custom_dialog.confirmAction(
                              context: context,
                              message:
                                  'Tem certeza que deseja excluir esta matriz?',
                              onConfirm: () {
                                BlocProvider.of<FramesCubit>(
                                  context,
                                ).onDeleteFrameSubmitted(
                                  frameId: state.frames[index].id,
                                );
                              },
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          'Nenhuma matriz encontrada.\n Adicione novas matrizes\npara começar a gerenciá-las.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
              }
              if (state.status.isFailure) {
                return GenericErrorComponent(
                  onRetry: () => BlocProvider.of<FramesCubit>(
                    context,
                  ).onGetFramesSubmitted(),
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
              '$frameRoute$createOrUpdateFrameRoute',
              arguments: {
                "onFrameCreatedOrUpdated": () {
                  BlocProvider.of<FramesCubit>(context).onGetFramesSubmitted();
                },
              },
            ),
            child: const Text('Adicionar'),
          ),
        ),
      ),
    );
  }

  Future<void> showLastUsageOrderDialog() {
    return showDialog<bool>(
      context: context,
      builder: (buildContext) {
        return Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Dialog(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 130,
              child: RadioGroup<LastUsageOrder>(
                groupValue: selected ?? LastUsageOrder.asc,
                onChanged: (LastUsageOrder? selectedOrder) {
                  setState(() {
                    selected = selectedOrder;
                  });
                  BlocProvider.of<FramesCubit>(context).onGetFramesSubmitted(
                    lastUsageOrderFilter: selectedOrder?.name,
                  );
                  _navigator.pop();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        'Usados recentemente',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      leading: Radio<LastUsageOrder>(
                        value: LastUsageOrder.desc,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'Não usados há muito tempo',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      leading: Radio<LastUsageOrder>(value: LastUsageOrder.asc),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
