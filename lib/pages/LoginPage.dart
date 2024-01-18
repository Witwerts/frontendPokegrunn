import 'package:flutter/material.dart';
import 'package:pokegrunn/controllers/AccountController.dart';
import 'package:pokegrunn/models/NavigationPageState.dart';
import 'package:provider/provider.dart';
import '../models/NavigationPage.dart';

class LoginPage extends NavigationPage  {
  const LoginPage({super.key});

  @override
  String get routePath => "/login";

  @override
  bool get loginNeeded => false;

  @override
  bool get showNavigation => false;

  @override
  NavigationPageState createState() => loginPageState();
}

class loginPageState extends NavigationPageState<LoginPage> {
  final _usernameInputController = TextEditingController();
  final _passwordInputController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    AccountController accountController = Provider.of<AccountController>(context);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LimitedBox(
              maxWidth: ((MediaQuery.of(context).size.width - 32) < 400)
                ? (MediaQuery.of(context).size.width - 32)
              : 400,
              child: Column(
                children: [
                  // Title
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Pokegrunn',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextField(
                    controller: _usernameInputController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      icon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: _passwordInputController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        icon: Icon(Icons.vpn_key)),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Builder(
                    builder: (context) => SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            var result = await accountController.login(_usernameInputController.text);
                            if (result) {
                              if (context.mounted) {
                                Navigator.pushReplacementNamed(context, accountController.requestedUrl);
                              }
                            } else {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Incorrecte gegevens')),
                                );
                              }
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    Text('Failed to login ${e.toString()}'),
                              ));
                            }
                          }
                        },
                        child: const Text(
                          'Login',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ]
    );
  }
}