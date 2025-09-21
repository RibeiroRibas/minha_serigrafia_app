import 'package:flutter/material.dart';
import 'package:minhaserigrafia/shared/ui/header_component.dart';
import 'package:minhaserigrafia/shared/ui/primary_container_component.dart';

class CompleteSignInPage extends StatefulWidget {
  const CompleteSignInPage({super.key});

  @override
  State<CompleteSignInPage> createState() => _CompleteSignInPageState();
}

class _CompleteSignInPageState extends State<CompleteSignInPage> {
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
                            onPressed: () {},
                            icon: Icon(Icons.arrow_back),
                          ),
                          Text(
                            'Complete seu Cadastro',
                            style: Theme.of(context).textTheme.bodyLarge,
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
