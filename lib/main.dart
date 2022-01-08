import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/google_auth.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/signin_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kakao_flutter_sdk/all.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  KakaoContext.clientId = "6f1078e092ca14c60168aec194eb6bef";
  KakaoContext.javascriptClientId = '7f252416a77dfa20889b312ecbe6c178';
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = Register();
  AuthClass authClass = AuthClass();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String? token = await authClass.getToken();
    if (token != null) {
      setState(() {
        currentPage = Home();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: currentPage);
  }
}
