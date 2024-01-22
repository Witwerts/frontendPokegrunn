import 'package:flutter/material.dart';
import 'package:pokegrunn/controllers/AccountController.dart';
import 'package:pokegrunn/controllers/NavigationController.dart';
import 'package:pokegrunn/models/MainApp.dart';
import 'package:pokegrunn/models/NavigationCategory.dart';
import 'package:pokegrunn/models/NavigationPageState.dart';
import 'package:pokegrunn/widgets/Titlebar.dart';
import 'package:provider/provider.dart';
import '../models/NavigationPage.dart';

class LoginPage extends NavigationPage  {
  const LoginPage({super.key});

  @override
  String get routePath => "login";

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

  bool disableButton = false;

  @override
  void initState() {
    super.initState();

    checkLoggedIn();
  }

  void checkLoggedIn() async {
    AccountController accountController = Provider.of<AccountController>(context, listen: false);
    NavigationController navController = Provider.of<NavigationController>(context, listen: false);

    bool loggedIn = await accountController.loadUser();

    if(loggedIn){
      print("already logged in...");

      setState(() {
        _usernameInputController.text = accountController.username!;
        _passwordInputController.text = "password";

        disableButton = true;
      });

      //wait & redirect
      await Future.delayed(Duration(seconds: 3));
      navController.switchTab(NavigationCategory.home.tabIndex);
      //navController.gotoPage("/", NavigationCategory.home.tabIndex);
    }
  }

  void login() async {
    AccountController accountController = Provider.of<AccountController>(context, listen: false);
    NavigationController navController = Provider.of<NavigationController>(context, listen: false);

    try {
      var result = await accountController.login(_usernameInputController.text);
      if (result) {
        if (context.mounted) {
          await Future.delayed(Duration(seconds: 3));
          navController.switchTab(NavigationCategory.home.tabIndex);
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
  }

  @override
  Widget build(BuildContext context) {
    AccountController accountController = Provider.of<AccountController>(context);
    NavigationController navController = Provider.of<NavigationController>(context);
    
    return Container(
      color: MainApp.color1,
      child: Stack(
        children: [
          const Titlebar(title: "PokeGrunn", barHeight: 130),
          Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 85, left: 20, right: 20),
                width: double.maxFinite,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.4),
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                      child: Text(
                        "Login",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                      child: Column(
                        children: [
                          TextField(
                            controller: _usernameInputController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Username',
                              prefixIcon: Icon(Icons.person),
                              contentPadding: EdgeInsets.fromLTRB(16, 12, 0, 12),
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          TextField(
                            controller: _passwordInputController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.vpn_key),
                              contentPadding: EdgeInsets.fromLTRB(16, 12, 0, 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 4, 4, 0),
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () => login(),
                        style: ElevatedButton.styleFrom(
                          primary: MainApp.color2,
                          onPrimary: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0), // Pas de hoekradius aan
                          ),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                    const SizedBox(
                      width: double.infinity, // Maximale breedte van de ouderwidget
                      child: Column(
                        
                        mainAxisAlignment: MainAxisAlignment.center, // Plaats beide teksten in het midden van de hoofdas (verticaal)
                        crossAxisAlignment: CrossAxisAlignment.center, // Plaats beide teksten in het midden van de kruisas (horizontaal)
                        children: [
                          Text(
                            "Forgot password? Click here!",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Click here to create a new account",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )
                    
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );

    /*return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
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
                ElevatedButton(
                  onPressed: () async {
                    try {
                      print(_usernameInputController.text);

                      var result = await accountController.login(_usernameInputController.text);
                      if (result) {
                        if (context.mounted) {
                          //Navigator.pushReplacementNamed(context, accountController.requestedUrl);
                          navController.switchTab(NavigationCategory.home.tabIndex);
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
              ],
            ),
          ],
        ),
      ]
    );*/
  }
}