import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_final_project/api/firebase_api.dart';
import 'package:intl/intl.dart';

import '../classes/Note.dart';

class AddNotePage extends StatefulWidget {
  AsyncSnapshot<UserCredential> userSnapshot;
  AddNotePage(this.userSnapshot);

  @override
  _AddNotePage createState() => _AddNotePage(userSnapshot);
}

class _AddNotePage extends State<AddNotePage> {

  Note noteObject = new Note();
  String name;
  String text;

  AsyncSnapshot<UserCredential> userSnapshot;
  _AddNotePage(this.userSnapshot);

  noteAddedDialog() {
    showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
              title: Center(child: Text("Note successfully added")),
            ),
        barrierDismissible: true
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text("Add Note"),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: "Note name",
                  ),
                  maxLength: 40,
                  onChanged: (noteNameInput) {
                    name = noteNameInput;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter note text",
                    border: OutlineInputBorder()
                  ),
                  maxLines: 5,
                  maxLength: 200,
                  onChanged: (noteTextInput) {
                    text = noteTextInput;
                  },
                ),
                TextButton(
                  child: Text("Add Note"),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      primary: Colors.black,
                      minimumSize: Size(80,40)
                  ),
                  onPressed: () {

                    DateTime timeNow = new DateTime.now();
                    String formatDate(DateTime date) => new DateFormat("MMMM d, hh:mm:ss").format(date);
                    String formattedTimeNow = formatDate(timeNow);
                    String timeNowAsString = formattedTimeNow.toString();

                    noteObject.noteName = name;
                    noteObject.noteText = text;
                    noteObject.timeStamp = timeNowAsString;
                    noteObject.userId = userSnapshot.data.user.uid;

                    if (noteObject.noteName == null || noteObject.noteText == null) {
                    // more conditions needed, this is just to demonstrate that it needs check
                      showDialog(
                          context: context,
                          builder: (_) =>
                              AlertDialog(
                                title: Center(child: Text("Please fill all fields")),
                              ),
                          barrierDismissible: true
                      );
                    } else {
                        FirestoreApi().addData(noteObject.toJson());
                        noteAddedDialog();
                      }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

