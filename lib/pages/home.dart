import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/pages/add_note.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => AddNote(),
            ),
          )
              .then((value) {
            print("calling set state");
            setState(() {});
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
      appBar: AppBar(
        title: Text(
          "Notes",
          style: TextStyle(
            fontSize: 32,
          ),
        ),
        // centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: ref.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot Map = snapshot.data!.docs[index];
                DateTime noteDateTime = Map['created'].toDate();
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${Map['title']}",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              DateFormat.yMMMd().add_jm().format(noteDateTime),
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white38),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
            // if (snapshot.data!.docs.length == 0) {
            //   return Center(
            //     child: Text(
            //       "Notunuz Bulunmamaktadır",
            //       style: TextStyle(color: Colors.red),
            //     ),
            //   );
            // }
          } else {
            return Center(
              child: Text("Yükleniyor...."),
            );
          }
        },
      ),
    );
  }
}
