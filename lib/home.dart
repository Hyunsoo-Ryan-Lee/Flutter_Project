import 'package:flutter/material.dart';
import 'package:flutter_application_1/google_auth.dart';
import 'package:flutter_application_1/google_map.dart';
import 'package:flutter_application_1/login_page.dart';
import 'package:flutter_application_1/viewNotes.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String kakaoMapKey = '6f1078e092ca14c60168aec194eb6bef';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthClass authClass = AuthClass();
  TextEditingController notesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                height: size.height * 0.05,
                width: size.width * 0.8,
                child: TextField(
                  controller: notesController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Text',
                  ),
                ),
              ),
              OutlinedButton(
                  onPressed: () {
                    setNoteData(notesController.text);
                  },
                  child: Text("Save")),
              OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ViewNotes()));
                  },
                  child: Text("View")),
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      notesController.text = '';
                    });
                  },
                  child: Text("refresh")),
              OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GoogleMapSearch()));
                  },
                  child: Text("Google Map")),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await authClass.logOut();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (builder) => LoginPage()),
                (route) => false);
          },
          child: Icon(Icons.logout),
        ),
      ),
    );
  }

  Future<void> setNoteData(noteValue) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('noteData', noteValue);
  }
}
