import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/modules/company/company_route_navigator.dart';
import 'package:minhaserigrafia/modules/company/ui/statistics_component.dart';
import 'package:minhaserigrafia/modules/company/ui/user_access_component.dart';
import 'package:minhaserigrafia/shared/ui/back_button_header_component.dart';

class CompanyPage extends StatefulWidget {
  const CompanyPage({super.key});

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  final _navigator = Modular.get<CompanyRouteNavigator>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                SizedBox(height: 8),
                BackButtonHeaderComponent(
                  title: 'Ribas Estamparia',
                  onBackPressed: () => _navigator.pop(),
                ),
                Divider(),
                UserAccessComponent(),
                Divider(),
                StatisticsComponent(),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
