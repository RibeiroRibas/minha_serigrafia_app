import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:minhaserigrafia/infra/storage/secure_storage_repository.dart';
import 'package:minhaserigrafia/modules/home/home_route_navigator.dart';
import 'package:minhaserigrafia/modules/profile/profile_route_navigator.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';
import 'package:minhaserigrafia/shared/ui/back_button_header_component.dart';

import '../signin/repository/firebase_auth_repository.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _navigator = Modular.get<ProfileRouteNavigator>();

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
                  title: 'Meu Perfil',
                  onBackPressed: () => _navigator.pop(),
                ),
                Divider(),
                OutlinedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Fale com a Gente'),
                      SvgPicture.asset(
                        'assets/images/whatsapp.svg',
                        width: 28,
                        height: 28,
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () async {
                    await Modular.get<FirebaseAuthRepository>().signOut();
                    await Modular.get<SecureStorageRepository>().deleteAll();
                    Modular.get<HomeRouteNavigator>().goTo(signInRoute);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sair do App'),
                      Icon(Icons.logout, size: 24.0),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Excluir Conta'),
                      const Icon(Icons.delete, size: 24),
                    ],
                  ),
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
