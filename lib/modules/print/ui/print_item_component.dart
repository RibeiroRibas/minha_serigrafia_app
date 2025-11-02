import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minhaserigrafia/modules/print/model/print_resumed_model.dart';
import 'package:minhaserigrafia/modules/signup/ui/primary_container_component.dart';

class PrintItemComponent extends StatelessWidget {
  final PrintResumedModel printModel;

  const PrintItemComponent({super.key, required this.printModel});

  @override
  Widget build(BuildContext context) {
    return PrimaryContainerComponent(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.numbers),
                    Text(
                      "Nome: ",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(printModel.name.toString()),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.person),
                    Text(
                      "Cliente: ",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(printModel.customerName),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.color_lens),
                    Text(
                      "Cores: ",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    for (String colorHex in printModel.colorsHex) ...{
                      Container(
                        width: 16,
                        height: 16,
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: _colorFromHex(colorHex),
                          border: Border.all(color: Colors.black),
                          borderRadius:  BorderRadius.circular(4),
                        ),
                      ),
                    },
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/frame.svg',
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Matrizes (Identificadores): ",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(printModel.framesIdentifiers.join(', ')),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_month),
                    SizedBox(width: 6),
                    Text(
                      "Usado por último: ",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(printModel.lastUsageAt),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right),
        ],
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
