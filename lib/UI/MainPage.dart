import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_final_project/UI/ViewNotePage.dart';
import 'package:flutter_app_final_project/api/authentication.dart';
import 'package:flutter_app_final_project/classes/Note.dart';

import 'AddNotePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Notes Saver'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  Note note;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return FutureBuilder<UserCredential>(
            future: anonymousLoginOrGetUser(),
            builder: (context, userSnapshot) => Scaffold(
              appBar: AppBar(
                title: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text("Notes Saver"),
                ),
              ),
              body: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("lib/assets/logo-notes.png")
                            )
                        ),
                      ),
                    ),
                    ListTile(
                      tileColor: Colors.indigo,
                      leading: Icon(Icons.search),
                      title: Text("View And Manage Notes"),
                      trailing: Icon(Icons.forward),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewNotePage()),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      tileColor: Colors.green,
                      leading: Icon(Icons.library_add),
                      title: Text("Add Note"),
                      trailing: Icon(Icons.forward),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotePage(userSnapshot)));
                      },
                    ),
                    SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}

