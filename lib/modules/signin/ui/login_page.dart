import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:minhaserigrafia/shared/ui/header_component.dart';
import 'package:minhaserigrafia/shared/ui/primary_container_component.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;

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
                height: 500,
                body: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(labelText: 'E-mail'),
                      ),
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        obscureText: _obscurePassword,
                      ),
                      ElevatedButton(onPressed: () {}, child: Text('Entrar')),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(fontSize: 16),
                          children: [
                            TextSpan(
                              text: 'Ainda não possui uma conta?\n',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: 'Cadastre-se!',
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {},
                            ),
                          ],
                        ),
                      ),
                      Text('Ou'),
                      OutlinedButton.icon(
                        icon: Image.asset(
                          'assets/images/google-color.png',
                          height: 24,
                          width: 24,
                        ),
                        label: Text(
                          'Continue com Google',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          // Add your Google sign-in logic here
                        },
                      ),
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
