import 'package:flutter/material.dart';
import 'package:flutter_application_1/google_auth.dart';
import 'package:flutter_application_1/register.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Home"),
          centerTitle: true,
        ),
        body: OutlinedButton(
          onPressed: () async {
            await authClass.logOut();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (builder) => Register()),
                (route) => false);
          },
          child: Text('LogOut'),
        ),
      ),
    );
  }
}
