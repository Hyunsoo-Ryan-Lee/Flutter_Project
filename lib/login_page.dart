import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/google_auth.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/signin_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AuthClass authClass = AuthClass();
  var currentuser = null;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("LOGIN"),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: size.height * 0.05,
                ),
                Text(
                  "Login with Email",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                ),
                SizedBox(height: size.height * 0.03),
                Loginform(Icons.mail, false, 'email', _emailController),
                Container(
                  height: size.height * 0.01,
                ),
                Loginform(Icons.vpn_key, true, 'password', _passwordController),
                SizedBox(height: size.height * 0.03),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    fixedSize: Size(300, 50),
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    "LOGIN",
                    style: new TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _login(context);
                    }
                  },
                ),
                SizedBox(height: size.height * 0.01),
                RichText(
                  text: TextSpan(
                    text: "If you don't have an account, click ",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'SIGN UP',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => Register()));
                            },
                          style: TextStyle(
                            color: Colors.blue,
                          )),
                      // TextSpan(text: 'text!'),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Divider(),
                ButtonItem("assets/google.svg", 'Google', 0.035),
                ButtonItem("assets/phone.svg", 'Mobile', 0.035),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void loginuser(BuildContext context) async {
  //   await FirebaseAuth.instance
  //       .setPersistence(Persistence.NONE)
  //       .then((value) => {
  //             FirebaseAuth.instance
  //                 .signInWithEmailAndPassword(
  //                     email: _emailController.text,
  //                     password: _passwordController.text)
  //                 .then(
  //                     (UserCredential) => {(currentuser = UserCredential.user)})
  //           });
  //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
  // }

  Future<dynamic> loginuser() =>
      FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

  void _login(BuildContext context) async {
    try {
      print('1');
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .then((value) => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Home())));
      print('2');
      final snackBar = SnackBar(
        content: const Text("You're logged in!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => Home()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        final snackBar = SnackBar(
          content: const Text("확인되지 않은 Email입니다."),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        final snackBar = SnackBar(
          content: const Text("비밀번호가 틀렸습니다."),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print('Wrong password provided for that user.');
      }
    }
  }

  Widget Loginform(var icon, bool obsecure, String hinttext,
      TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 30),
      child: TextFormField(
        obscureText: obsecure,
        decoration: InputDecoration(
            icon: Icon(icon),
            hintText: hinttext,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  width: 0,
                ))),
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please input correct $hinttext';
          } else if (value.length < 6) {
            return '$hinttext는 최소 6자 이상입니다.';
          }
          return null;
        },
      ),
    );
  }

  Widget ButtonItem(String imagepath, String buttonname, double buttonsize) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () async {
        await authClass.googleSignIn(context);
      },
      child: Container(
        width: size.width * 0.6,
        height: size.height * 0.06,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(width: 1, color: Colors.black)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imagepath,
                height: size.height * buttonsize,
              ),
              SizedBox(
                width: size.width * 0.03,
              ),
              Text('Continue with $buttonname')
            ],
          ),
        ),
      ),
    );
  }
}
