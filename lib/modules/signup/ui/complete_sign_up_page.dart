import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:minhaserigrafia/modules/signup/sign_up_route_navigator.dart';
import 'package:minhaserigrafia/shared/routes/route_named.dart';
import 'package:minhaserigrafia/shared/ui/header_component.dart';
import 'package:minhaserigrafia/shared/ui/primary_container_component.dart';

class CompleteSignInPage extends StatefulWidget {
  const CompleteSignInPage({super.key});

  @override
  State<CompleteSignInPage> createState() => _CompleteSignInPageState();
}

class _CompleteSignInPageState extends State<CompleteSignInPage> {
  final _navigator = Modular.get<SignUpRouteNavigator>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HeaderComponent(),
              PrimaryContainerComponent(
                height: 400,
                body: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => _navigator.goTo('$signInRoute/'),
                            icon: Icon(Icons.arrow_back),
                          ),
                          Text(
                            'Complete seu Cadastro',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Nome da Empresa',
                        ),
                      ),
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(labelText: 'Celular'),
                        inputFormatters: [
                          MaskedInputFormatter('(##) #####-####'),
                        ],
                      ),
                      ElevatedButton(onPressed: () {}, child: Text('Concluir')),
                    ],
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
