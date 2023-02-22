import 'package:assignment2/mainmenu.dart';
import 'package:assignment2/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({super.key, required this.user});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('HOMESTAY RAYA'),
            actions: [
              IconButton(onPressed: _logout, icon: const Icon(Icons.logout))
            ],
          ),
          drawer: MainMenuWidget(user: widget.user),
          body: Center(
            child: SizedBox(
                width: 250,
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Location:", style: TextStyle(fontSize: 20)),
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Where to go?",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        MaterialButton(
                            onPressed: () {
                              //_pressMe(textEditingController.text);
                            },
                            color: Theme.of(context).colorScheme.primary,
                            child: const Text("Search",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ))),
                        const SizedBox(
                          height: 8,
                        ),
                      ]),
                )),
          ),
        ));
  }

  User user = User(
      id: "0",
      email: "unregistered",
      name: "unregistered",
      phone: "0123456789");

  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Log out?",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
                onPressed: _yesButton,
                child: const Text(
                  "Yes",
                  style: TextStyle(),
                )),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _yesButton() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (content) => MainScreen(
                  user: user,
                )));
    Fluttertoast.showToast(
        msg: "Logout Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 14.0);
  }
}