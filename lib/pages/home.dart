import 'package:flutter/material.dart';
import 'package:note_app/pages/add_note.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddNote(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
      appBar: AppBar(
        title: Text("Notes"),
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),
      body: Center(
        child: Text("Notes"),
      ),
    );
  }
}
