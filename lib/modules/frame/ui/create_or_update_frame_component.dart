import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:formz/formz.dart';
import 'package:minhaserigrafia/modules/frame/cubit/create_or_update_frame_cubit.dart';
import 'package:minhaserigrafia/modules/frame/frame_route_navigator.dart';
import 'package:minhaserigrafia/modules/frame/model/frame_material_enum.dart';
import 'package:minhaserigrafia/modules/frame/model/frame_model.dart';
import 'package:minhaserigrafia/modules/frame/model/frame_print_model.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';
import 'package:minhaserigrafia/shared/theme/theme_colors.dart';
import 'package:minhaserigrafia/shared/ui/date_picker_field.dart';

class CreateOrUpdateFrameComponent extends StatelessWidget {
  final FrameModel frameModel;

  const CreateOrUpdateFrameComponent({super.key, required this.frameModel});

  @override
  Widget build(BuildContext context) {
    if (frameModel.id > 0) {
      BlocProvider.of<CreateOrUpdateFrameCubit>(context).setModel(frameModel);
    }
    return Column(
      spacing: 8.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _IdentifierInput(identifier: frameModel.identifier),
        const SizedBox(height: 12),
        _PrintsSelected(framesIdentifiers: frameModel.prints),
        const SizedBox(height: 12),
        _MaterialInput(material: frameModel.material),
        const SizedBox(height: 12),
        _SizeInput(size: frameModel.size),
        const SizedBox(height: 12),
        _LinesInput(lines: frameModel.lines),
        const SizedBox(height: 12),
        DatePickerField(
          initialDate: frameModel.lastUsageAt,
          onDateChanged: (date) {
            BlocProvider.of<CreateOrUpdateFrameCubit>(
              context,
            ).onLastUsageDateChanged(date);
          },
        ),
        const SizedBox(height: 12),
        if (frameModel.createdAt.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  const TextSpan(text: 'Criado em: '),
                  TextSpan(
                    text: frameModel.createdAt,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 12),
        _SaveButton(frameId: frameModel.id),
      ],
    );
  }
}

class _IdentifierInput extends StatefulWidget {
  final String identifier;

  const _IdentifierInput({required this.identifier});

  @override
  State<_IdentifierInput> createState() => _IdentifierInputState();
}

class _IdentifierInputState extends State<_IdentifierInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.identifier);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayError = context.select(
      (CreateOrUpdateFrameCubit bloc) => bloc.state.identifier.displayError,
    );

    final frameIdentifierInUse = context.select(
      (CreateOrUpdateFrameCubit bloc) => bloc.state.frameIdentifierInUse,
    );

    return TextField(
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      controller: _controller,
      onChanged: (identifier) {
        BlocProvider.of<CreateOrUpdateFrameCubit>(
          context,
        ).onIdentifierChanged(identifier);
      },
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: 'Identificador da Matriz*',
        errorText: frameIdentifierInUse
            ? 'Já existe uma matriz registrada com este identificador.'
            : displayError != null
            ? 'Campo obrigatório.'
            : null,
      ),
    );
  }
}

class _PrintsSelected extends StatefulWidget {
  final List<FramePrintModel> framesIdentifiers;

  const _PrintsSelected({required this.framesIdentifiers});

  @override
  State<_PrintsSelected> createState() => _PrintsSelectedState();
}

class _PrintsSelectedState extends State<_PrintsSelected> {
  final List<FramePrintModel> selectedPrints = [];

  @override
  void initState() {
    super.initState();
    selectedPrints.addAll(widget.framesIdentifiers);
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Modular.get<FrameRouteNavigator>();

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
                    'Estampas',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  IconButton(
                    onPressed: () {
                      navigator.pushNamed(
                        printRoute,
                        arguments: {
                          'onPrintSelected': (int printId, String printName) {
                            setState(() {
                              selectedPrints.add(
                                FramePrintModel(
                                  id: printId,
                                  printName: printName,
                                ),
                              );
                            });
                            BlocProvider.of<CreateOrUpdateFrameCubit>(
                              context,
                            ).onPrintIdChanged(printId);
                          },
                        },
                      );
                    },
                    icon: Icon(Icons.add_circle),
                  ),
                ],
              ),
            ),
            for (FramePrintModel print in selectedPrints) ...{
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
                        print.printName,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            selectedPrints.remove(print);
                          });
                          BlocProvider.of<CreateOrUpdateFrameCubit>(
                            context,
                          ).onRemovePrintId(print.id);
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

typedef MenuEntry = DropdownMenuEntry<String>;

class _MaterialInput extends StatelessWidget {
  final String material;

  const _MaterialInput({required this.material});

  @override
  Widget build(BuildContext context) {
    final List<MenuEntry> menuEntries = UnmodifiableListView<MenuEntry>(
      FrameMaterial.values.map<MenuEntry>(
        (FrameMaterial frameMaterial) =>
            MenuEntry(value: frameMaterial.label, label: frameMaterial.label),
      ),
    );

    final String initialValue = material.isNotEmpty
        ? material
        : FrameMaterial.wood.label;

    return DropdownMenu<String>(
      textStyle: Theme.of(context).textTheme.bodyLarge,
      width: double.infinity,
      label: Text('Material da Matriz'),
      initialSelection: initialValue,
      onSelected: (String? value) {
        BlocProvider.of<CreateOrUpdateFrameCubit>(
          context,
        ).onMaterialChanged(FrameMaterial.fromString(value!));
      },
      dropdownMenuEntries: menuEntries,
    );
  }
}

class _SizeInput extends StatefulWidget {
  final String size;

  const _SizeInput({required this.size});

  @override
  State<_SizeInput> createState() => _SizeInputState();
}

class _SizeInputState extends State<_SizeInput> {
  late final TextEditingController _controllerOne;
  late final TextEditingController _controllerTwo;
  late String frameWidth;
  late String frameHeight;

  @override
  void initState() {
    super.initState();
    final sizeParts = widget.size.split('x');
    frameWidth = sizeParts.isNotEmpty ? sizeParts[0] : '';
    frameHeight = sizeParts.length > 1 ? sizeParts[1] : '';
    _controllerOne = TextEditingController(text: frameWidth);
    _controllerTwo = TextEditingController(text: frameHeight);
  }

  @override
  void dispose() {
    _controllerOne.dispose();
    _controllerTwo.dispose();
    super.dispose();
  }

  void _trySendSize() {
    if (frameWidth.trim().isNotEmpty && frameHeight.trim().isNotEmpty) {
      final sizeValue = '${frameWidth.trim()}x${frameHeight.trim()}';
      BlocProvider.of<CreateOrUpdateFrameCubit>(
        context,
      ).onSizeChanged(sizeValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
          child: Text(
            "Tamanho da Matriz",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _controllerOne,
                onChanged: (size) {
                  setState(() => frameWidth = size);
                  _trySendSize();
                },
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(labelText: 'Largura'),
              ),
            ),
            const SizedBox(width: 8),
            const Text('x'),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _controllerTwo,
                onChanged: (size) {
                  setState(() => frameHeight = size);
                  _trySendSize();
                },
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(labelText: 'Altura'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _LinesInput extends StatefulWidget {
  final String lines;

  const _LinesInput({required this.lines});

  @override
  State<_LinesInput> createState() => _LinesInputState();
}

class _LinesInputState extends State<_LinesInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.lines);
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
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: (value) {
        BlocProvider.of<CreateOrUpdateFrameCubit>(
          context,
        ).onLinesChanged(value);
      },
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(labelText: 'Quantidade de fios'),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final int frameId;

  const _SaveButton({required this.frameId});

  @override
  Widget build(BuildContext context) {
    final isInProgress = context.select(
      (CreateOrUpdateFrameCubit bloc) => bloc.state.status.isInProgress,
    );

    if (isInProgress) return const CircularProgressIndicator();

    final isValid = context.select(
      (CreateOrUpdateFrameCubit bloc) => bloc.state.isValid,
    );

    return ElevatedButton(
      onPressed: isValid && frameId == 0
          ? () => BlocProvider.of<CreateOrUpdateFrameCubit>(
              context,
            ).onCreateFrameSubmitted()
          : isValid && frameId > 0
          ? () => BlocProvider.of<CreateOrUpdateFrameCubit>(
              context,
            ).onUpdateFrameSubmitted()
          : null,
      child: const Text('Salvar'),
    );
  }
}
