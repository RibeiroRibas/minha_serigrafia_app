import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:minhaserigrafia/infra/storage/secure_storage_repository.dart';
import 'package:minhaserigrafia/modules/home/home_route_navigator.dart';
import 'package:minhaserigrafia/modules/signin/repository/firebase_auth_repository.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Home Page")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Modular.get<FirebaseAuthRepository>().signOut();
          await Modular.get<SecureStorageRepository>().deleteAll();
          Modular.get<HomeRouteNavigator>().goTo(signInRoute);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
