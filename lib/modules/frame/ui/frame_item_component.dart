import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minhaserigrafia/modules/frame/model/frame_resumed_model.dart';
import 'package:minhaserigrafia/modules/signup/ui/primary_container_component.dart';

class FrameItemComponent extends StatelessWidget {
  final FrameResumedModel frameModel;

  const FrameItemComponent({super.key, required this.frameModel});

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
                      "Identificador: ",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(frameModel.identifier.toString()),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/images/tshirt.svg',
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Estampas: ",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Flexible(child: Text(_getPrintsWithCustomers())),
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
                    Text(frameModel.lastUsageAt),
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

  String _getPrintsWithCustomers() => frameModel.prints
      .map((p) => '${p.printName}(${p.customerName})')
      .join(' ');
}
