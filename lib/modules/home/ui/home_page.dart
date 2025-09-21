import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // final GoogleSignIn signIn = GoogleSignIn.instance;
          // await signIn.initialize();
          // try {
          //   GoogleSignInAccount user = await signIn.authenticate();
          //   print('sucesso -----------------');
          //   print(user.email);
          // } catch (e) {
          //   print('Erro -----------------------------------------');
          //   print(e.toString());
          // }
        },
        tooltip: 'Login com google',
        child: const Icon(Icons.add),
      ),
    );
  }
}
