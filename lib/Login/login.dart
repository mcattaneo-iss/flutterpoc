import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "dart:convert";
import "dart:async";

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _MyAppState();
}

class _MyAppState extends State<Login> {
  final loginForm = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool? saveUsername = false;
  bool? savePassword = false;
  String? savedUsername = "";
  String? savedPassword = "";

  @override
  void initState() {
    super.initState();
    usernameController.clear();
    passwordController.clear();
    getVariables();
  }

  void getVariables() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      saveUsername = prefs.getBool('saveUsername') ?? saveUsername;
      savePassword = prefs.getBool('savePassword') ?? savePassword;
      savedUsername = prefs.getString('savedUsername') ?? savedUsername;
      savedPassword = prefs.getString('savedPassword') ?? savedPassword;
    });

    if (savedUsername != '') {
      usernameController.text = savedUsername!;
    }
    if (savedPassword != '') {
      passwordController.text = savedPassword!;
    }
  }

  Future<http.Response> login(String username, String password) async {
    var body = {
      "secret": "942667ec-fc38-4dcd-a30f-4569ccadb1ac",
      "password": password,
      "deviceName": "iPad (8th generation)",
      "deviceID": "302e31a9-cf84-435e-9777-f4a63f763ff5",
      "companyCode": "ar",
      "username": username,
      "truckNumber": null,
      "application": "com.ahern.communicationcenter"
    };

    try {
      final result = http.post(
        Uri.parse('https://api.ahern.com/api/utilities/v1/authenticate'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body),
      );
      return result;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void processLogin(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('activeUser', usernameController.text);

    if (saveUsername!) {
      await prefs.setString('savedUsername', usernameController.text);
    } else {
      await prefs.setString('savedUsername', '');
    }

    if (savePassword!) {
      await prefs.setString('savedPassword', passwordController.text);
    } else {
      await prefs.setString('savedPassword', '');
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          backgroundColor: const Color(0xFF212121),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            child: Image.asset('assets/images/EquipTraceLogo.png'),
          ),
          Form(
            key: loginForm,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: usernameController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Username',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  SwitchListTile(
                    value: saveUsername!,
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.green,
                    onChanged: (bool value) async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('saveUsername', value);
                      setState(() {
                        saveUsername = value;
                        if (!value) {
                          savePassword = value;
                        }
                      });
                    },
                    title: const Text(
                        style: TextStyle(color: Colors.white), "Save Username"),
                  ),
                  SwitchListTile(
                    value: savePassword!,
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.green,
                    onChanged: (bool value) async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('savePassword', value);
                      if (value) {
                        await prefs.setBool('saveUsername', value);
                      }
                      setState(() {
                        savePassword = value;
                        if (value) {
                          saveUsername = value;
                        }
                      });
                    },
                    title: const Text(
                        style: TextStyle(color: Colors.white), "Save Password"),
                  ),
                  Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      onPressed: () async {
                        context.loaderOverlay.show();
                        var result = await login(
                            usernameController.text, passwordController.text);
                        var response = jsonDecode(result.body);
                        if (result.statusCode == 200) {
                          processLogin(response['head']['token']);
                          context.loaderOverlay.hide();
                          if (!mounted) return;
                          Navigator.pushNamed(context, "/dashboard");
                        } else {
                          print(response['head']);
                        }
                        context.loaderOverlay.hide();
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                ]),
          ),
          Expanded(
            child: Container(),
          )
        ]));
  }
}
