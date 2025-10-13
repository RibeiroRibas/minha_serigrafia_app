import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/modules/home/home_route_navigator.dart';
import 'package:minhaserigrafia/modules/home/ui/menu_item_component.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';
import 'package:minhaserigrafia/shared/ui/header_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Column(
            children: [
              HeaderComponent(color: Colors.white),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(36.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            spacing: 16.0,
                            runSpacing: 32.0,
                            children: [
                              MenuItemComponent(
                                title: 'Produção',
                                icon: const Icon(Icons.factory),
                              ),
                              MenuItemComponent(
                                title: 'Estampas',
                                svgImagePath: 'assets/images/tshirt.svg',
                              ),
                              MenuItemComponent(
                                title: 'Matrizes',
                                svgImagePath: 'assets/images/frame.svg',
                              ),
                              MenuItemComponent(
                                title: 'Clientes',
                                icon: const Icon(Icons.person),
                              ),
                              GestureDetector(
                                child: MenuItemComponent(
                                  title: 'Empresa',
                                  icon: const Icon(Icons.business),
                                ),
                                onTap: () {
                                  Modular.get<HomeRouteNavigator>().pushNamed(
                                    companyRoute,
                                  );
                                },
                              ),
                              GestureDetector(
                                child: MenuItemComponent(
                                  title: 'Perfil',
                                  icon: const Icon(Icons.account_circle),
                                ),
                                onTap: () {
                                  Modular.get<HomeRouteNavigator>().pushNamed(
                                    profileRoute,
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
