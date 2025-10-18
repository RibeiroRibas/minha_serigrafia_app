import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/modules/company/company_route_navigator.dart';
import 'package:minhaserigrafia/modules/company/model/user_access_model.dart';
import 'package:minhaserigrafia/modules/signup/ui/primary_container_component.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';
import 'package:minhaserigrafia/shared/ui/custom_snack_bar.dart';

class UserAccessComponent extends StatelessWidget {
  final VoidCallback onAccessCreate;
  final List<UserAccessModel> accesses;

  const UserAccessComponent({super.key, required this.accesses, required this.onAccessCreate});

  @override
  Widget build(BuildContext context) {
    final navigator = Modular.get<CompanyRouteNavigator>();

    return Column(
      spacing: 16,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Acessos:', style: Theme.of(context).textTheme.titleMedium),
            SizedBox(
              width: 180,
              child: ElevatedButton(
                onPressed: () async {
                  final result = await navigator.pushNamed(
                    '$companyRoute$createAccessRoute',
                  );
                  if (context.mounted && result == true) {
                    showCustomSnackBar(
                      context,
                      'Acesso criado com sucesso!',
                      type: SnackBarType.success,
                    );
                    onAccessCreate.call();
                  }
                },
                child: const Text('Incluir Acesso'),
              ),
            ),
          ],
        ),
        ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 12);
          },
          shrinkWrap: true,
          itemCount: accesses.length,
          itemBuilder: (BuildContext context, int index) {
            return PrimaryContainerComponent(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(accesses[index].name),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
