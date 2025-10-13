import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/modules/company/company_route_navigator.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';
import 'package:minhaserigrafia/shared/theme/theme_colors.dart';

class UserAccessComponent extends StatelessWidget {
  const UserAccessComponent({super.key});

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
                onPressed: () => navigator.pushNamed('$companyRoute$createAccessRoute'),
                child: const Text('Incluir Acesso'),
              ),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: ThemeColors.grayLight2, width: 2.0),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('José da Silva'),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
