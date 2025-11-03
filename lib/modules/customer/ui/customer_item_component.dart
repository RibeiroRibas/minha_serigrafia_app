import 'package:flutter/material.dart';
import 'package:minhaserigrafia/modules/customer/model/customer_resumed_model.dart';
import 'package:minhaserigrafia/modules/signup/ui/primary_container_component.dart';

class CustomerItemComponent extends StatelessWidget {
  final CustomerResumedModel customerModel;

  const CustomerItemComponent({super.key, required this.customerModel});

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
                    Text(customerModel.name),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.phone),
                    SizedBox(width: 6),
                    Text(
                      "Telefone: ",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(customerModel.phone),
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
}
