import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/modules/print/print_route_navigator.dart';
import 'package:minhaserigrafia/shared/theme/theme_colors.dart';
import 'package:minhaserigrafia/shared/ui/back_button_header_component.dart';

class ColorPickerPage extends StatefulWidget {
  final Function(String) onColorSelected;
  final String? initialColorHex;

  const ColorPickerPage({
    super.key,
    required this.onColorSelected,
    this.initialColorHex,
  });

  @override
  State<ColorPickerPage> createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage> {
  late Color screenPickerColor;
  final navigator = Modular.get<PrintRouteNavigator>();

  @override
  void initState() {
    super.initState();
    screenPickerColor = widget.initialColorHex != null
        ? Color(int.parse(widget.initialColorHex!.replaceFirst('#', '0xff')))
        : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 24),
              BackButtonHeaderComponent(
                title: 'Selecionar cor',
                onBackPressed: () => navigator.pop(),
              ),
              Padding(
                padding: const EdgeInsets.all(6),
                child: Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.grayLight,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: ThemeColors.grayLight2, width: 1),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: ColorPicker(
                    hasBorder: true,
                    borderColor: Colors.black,
                    pickerTypeLabels: const {
                      ColorPickerType.both: 'Paleta',
                      ColorPickerType.primary: 'Primárias',
                      ColorPickerType.accent: 'Accent',
                      ColorPickerType.bw: 'P&B',
                      ColorPickerType.custom: 'Custom',
                      ColorPickerType.wheel: 'Cromático',
                    },
                    selectedPickerTypeColor: Theme.of(
                      context,
                    ).colorScheme.primary,
                    pickersEnabled: const <ColorPickerType, bool>{
                      ColorPickerType.both: true,
                      ColorPickerType.primary: false,
                      ColorPickerType.accent: false,
                      ColorPickerType.bw: true,
                      ColorPickerType.custom: true,
                      ColorPickerType.wheel: true,
                    },
                    color: screenPickerColor,
                    onColorChanged: (Color color) =>
                        setState(() => screenPickerColor = color),
                    width: 44,
                    height: 44,
                    borderRadius: 22,
                    subheading: Text(
                      '',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: screenPickerColor,
              side: const BorderSide(color: ThemeColors.grayLight2, width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              widget.onColorSelected(screenPickerColor.hex);
              navigator.pop();
            },
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: ThemeColors.grayLight,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: ThemeColors.grayLight2, width: 1),
              ),
              child: Icon(Icons.check, color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
