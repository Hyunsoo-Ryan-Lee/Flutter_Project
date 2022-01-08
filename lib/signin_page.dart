import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/google_auth.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/login_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("SIGN UP"),
          centerTitle: true,
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
                  "Sign up with Email",
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
                    "SIGN UP",
                    style: new TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _register(context);
                    }
                  },
                ),
                SizedBox(height: size.height * 0.01),
                RichText(
                  text: TextSpan(
                    text: 'If you already signed in, click ',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'LOGIN',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
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

  void _register(BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
      final snackBar = SnackBar(
        content: const Text("You're signed up!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        final snackBar = SnackBar(
          content: const Text("비밀번호는 6자 이상 입력해주세요"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        final snackBar = SnackBar(
          content: const Text("이미 사용중인 Email입니다."),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
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
