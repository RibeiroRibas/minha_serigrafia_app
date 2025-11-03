import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/print/cubit/create_or_update_print_cubit.dart';
import 'package:minhaserigrafia/modules/print/model/print_frame_model.dart';
import 'package:minhaserigrafia/modules/print/model/print_model.dart';
import 'package:minhaserigrafia/modules/print/print_route_navigator.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';
import 'package:minhaserigrafia/shared/theme/theme_colors.dart';
import 'package:minhaserigrafia/shared/ui/date_picker_field.dart';

class CreateOrUpdatePrintComponent extends StatelessWidget {
  final PrintModel printModel;

  const CreateOrUpdatePrintComponent({super.key, required this.printModel});

  @override
  Widget build(BuildContext context) {
    if (printModel.id > 0) {
      BlocProvider.of<CreateOrUpdatePrintCubit>(context).setModel(printModel);
    }
    return Column(
      spacing: 8.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _NameInput(name: printModel.name),
        const SizedBox(height: 12),
        _CustomerInput(customerName: printModel.customerName),
        const SizedBox(height: 12),
        _FramesSelected(framesIdentifiers: printModel.frames),
        const SizedBox(height: 12),
        _ColorsSelected(colors: printModel.colorsHex),
        const SizedBox(height: 12),
        _DetailsInput(details: printModel.details),
        const SizedBox(height: 12),
        DatePickerField(
          initialDate: printModel.lastUsageAt,
          onDateChanged: (date) {
            BlocProvider.of<CreateOrUpdatePrintCubit>(
              context,
            ).onLastUsageDateChanged(date);
          },
        ),
        const SizedBox(height: 12),
        if (printModel.createdAt.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  const TextSpan(text: 'Criado em: '),
                  TextSpan(
                    text: printModel.createdAt,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 12),
        _SaveButton(printId: printModel.id),
      ],
    );
  }
}

class _NameInput extends StatefulWidget {
  final String name;

  const _NameInput({required this.name});

  @override
  State<_NameInput> createState() => _NameInputState();
}

class _NameInputState extends State<_NameInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.name);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (CreateOrUpdatePrintCubit bloc) => bloc.state.name.displayError,
    );

    final printNameInUse = context.select(
      (CreateOrUpdatePrintCubit bloc) => bloc.state.printNameInUse,
    );

    return TextField(
      controller: _controller,
      onChanged: (name) {
        BlocProvider.of<CreateOrUpdatePrintCubit>(context).onNameChanged(name);
      },
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: 'Nome da Estampa*',
        errorText: printNameInUse
            ? 'Já existe uma estampa registrada com este nome.'
            : displayError != null
            ? 'Campo obrigatório.'
            : null,
      ),
    );
  }
}

typedef MenuEntry = DropdownMenuEntry<String>;

class _CustomerInput extends StatefulWidget {
  final String customerName;

  const _CustomerInput({required this.customerName});

  @override
  State<_CustomerInput> createState() => _CustomerInputState();
}

class _CustomerInputState extends State<_CustomerInput> {
  late final TextEditingController _controller;
  final _navigator = Modular.get<PrintRouteNavigator>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.customerName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      onTap: () => _navigator.pushNamed(
        customerRoute,
        arguments: {
          'onCustomerSelected': (int customerId, String customerName) {
            _controller.text = customerName;
            BlocProvider.of<CreateOrUpdatePrintCubit>(
              context,
            ).onCustomerIdChanged(customerId.toString());
          },
        },
      ),
      controller: _controller,
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.add_circle,
          color: Theme.of(context).primaryColor,
        ),
        hintText: 'Pesquisar cliente...',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}

class _FramesSelected extends StatefulWidget {
  final List<PrintFrameModel> framesIdentifiers;

  const _FramesSelected({required this.framesIdentifiers});

  @override
  State<_FramesSelected> createState() => _FramesSelectedState();
}

class _FramesSelectedState extends State<_FramesSelected> {
  final List<PrintFrameModel> selectedFramesIdentifiers = [];

  @override
  void initState() {
    super.initState();
    selectedFramesIdentifiers.addAll(widget.framesIdentifiers);
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Modular.get<PrintRouteNavigator>();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                spacing: 8.0,
                children: [
                  Text(
                    'Matrizes',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  IconButton(
                    onPressed: () {
                      navigator.pushNamed(
                        frameRoute,
                        arguments: {
                          'onFrameSelected':
                              (int frameId, int frameIdentifier) {
                                setState(() {
                                  selectedFramesIdentifiers.add(
                                    PrintFrameModel(
                                      id: frameId,
                                      identifier: frameIdentifier,
                                    ),
                                  );
                                });
                                BlocProvider.of<CreateOrUpdatePrintCubit>(
                                  context,
                                ).onFrameIdChanged(frameId);
                              },
                        },
                      );
                    },
                    icon: Icon(Icons.add_circle),
                  ),
                ],
              ),
            ),
            for (PrintFrameModel frame in selectedFramesIdentifiers) ...{
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.grayLight2,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Identificador: ${frame.identifier}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            selectedFramesIdentifiers.remove(frame);
                          });
                          BlocProvider.of<CreateOrUpdatePrintCubit>(
                            context,
                          ).onRemoveFrameId(frame.id);
                        },
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            },
          ],
        ),
      ),
    );
  }
}

class _ColorsSelected extends StatefulWidget {
  final List<String> colors;

  const _ColorsSelected({required this.colors});

  @override
  State<_ColorsSelected> createState() => _ColorsSelectedState();
}

class _ColorsSelectedState extends State<_ColorsSelected> {
  final List<String> selectedColors = [];

  @override
  void initState() {
    super.initState();
    selectedColors.addAll(widget.colors);
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Modular.get<PrintRouteNavigator>();

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                spacing: 8.0,
                children: [
                  Text('Cores', style: Theme.of(context).textTheme.titleSmall),
                  IconButton(
                    onPressed: () {
                      navigator.pushNamed(
                        '$printRoute$selectColorRoute',
                        arguments: {
                          'onColorSelected': (String colorHex) {
                            setState(() {
                              selectedColors.add(colorHex);
                            });
                            BlocProvider.of<CreateOrUpdatePrintCubit>(
                              context,
                            ).onColorHexChanged(colorHex);
                          },
                        },
                      );
                    },
                    icon: Icon(Icons.add_circle),
                  ),
                ],
              ),
            ),
            for (String color in selectedColors) ...{
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: _colorFromHex(color),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black),
                  ),
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ThemeColors.grayLight,
                        ),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              selectedColors.remove(color);
                            });
                            BlocProvider.of<CreateOrUpdatePrintCubit>(
                              context,
                            ).onRemoveColorHex(color);
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            },
          ],
        ),
      ),
    );
  }

  Color _colorFromHex(String hex) {
    final cleaned = hex.replaceFirst('#', '').toUpperCase();
    final buffer = StringBuffer();
    if (cleaned.length == 6) buffer.write('FF');
    buffer.write(cleaned);
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

class _DetailsInput extends StatefulWidget {
  final String details;

  const _DetailsInput({required this.details});

  @override
  State<_DetailsInput> createState() => _DetailsInputState();
}

class _DetailsInputState extends State<_DetailsInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.details);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: (text) {
        BlocProvider.of<CreateOrUpdatePrintCubit>(
          context,
        ).onDetailsChanged(text);
      },
      style: const TextStyle(color: Colors.black),
      maxLines: 6,
      maxLength: 200,
      inputFormatters: [LengthLimitingTextInputFormatter(200)],
      decoration: InputDecoration(
        labelText: 'Detalhes da Estampa',
        alignLabelWithHint: true,
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final int printId;

  const _SaveButton({required this.printId});

  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (CreateOrUpdatePrintCubit bloc) => bloc.state.status.isInProgress,
    );

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select(
      (CreateOrUpdatePrintCubit bloc) => bloc.state.isValid,
    );

    return ElevatedButton(
      onPressed: isValid && printId == 0
          ? () => BlocProvider.of<CreateOrUpdatePrintCubit>(
              context,
            ).onCreatePrintSubmitted()
          : isValid && printId > 0
          ? () => BlocProvider.of<CreateOrUpdatePrintCubit>(
              context,
            ).onUpdatePrintSubmitted()
          : null,
      child: const Text('Salvar'),
    );
  }
}
