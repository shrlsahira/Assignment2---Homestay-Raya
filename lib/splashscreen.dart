import 'dart:async';
import 'dart:convert';
import 'package:assignment2/config.dart';
import 'package:assignment2/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mainscreen.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    autoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assignment/assignment2/assets/image/pic.png'),
                    fit: BoxFit.cover))),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              CircularProgressIndicator(),
              Text(
                "Version 0.1",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              )
            ],
          ),
        )
      ],
    );
  }

  Future<void> autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _email = (prefs.getString('email')) ?? '';
    String _pass = (prefs.getString('pass')) ?? '';
    try {
      if (_email.isNotEmpty) {
        http.post(Uri.parse("${CONFIG.server}/php/login_user.php"),
            body: {"email": _email, "password": _pass}).then((response) {
          var jsonResponse = json.decode(response.body);
          if (response.statusCode == 200 &&
              jsonResponse['status'] == "success") {
            User user = User.fromJson(jsonResponse['data']);
            Timer(
                const Duration(seconds: 3),
                () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => MainScreen(user: user))));
          } else {
            User user = User(
                id: "0",
                email: "unregistered",
                name: "unregistered",
                phone: "0123456789");
            Timer(
                const Duration(seconds: 3),
                () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => MainScreen(user: user))));
          }
        });
      } else {
        User user = User(
            id: "0",
            email: "unregistered",
            name: "unregistered",
            phone: "0123456789");
        Timer(
            const Duration(seconds: 3),
            () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (content) => MainScreen(user: user))));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}