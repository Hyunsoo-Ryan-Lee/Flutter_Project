import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewNotes extends StatefulWidget {
  const ViewNotes({Key? key}) : super(key: key);

  @override
  _ViewNotesState createState() => _ViewNotesState();
}

class _ViewNotesState extends State<ViewNotes> {
  String? noteValue;

  @override
  void initState() {
    super.initState();
    getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Text'),
      ),
      body: Center(
        child:
            noteValue == '' ? Text('No Notes are Avaliable') : Text(noteValue!),
      ),
    );
  }

  Future<void> getNotes() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    noteValue = pref.getString('noteData');
    setState(() {});
  }
}
