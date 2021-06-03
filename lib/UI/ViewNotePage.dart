import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_final_project/api/firebase_api.dart';

class ViewNotePage extends StatefulWidget {

  @override
  _ViewNotePage createState() => _ViewNotePage();
}

class _ViewNotePage extends State<ViewNotePage> {

  GlobalKey<RefreshIndicatorState> refreshKey;

  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    refreshKey = GlobalKey<RefreshIndicatorState>();
  }

  Widget showEntries() {
    return FutureBuilder(
        future: FirestoreApi().getPosts(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (_, index) {
                  String currentTimeStamp = snapshot.data[index]
                      .data()['timeStamp'];
                  String currentUserId = snapshot.data[index].data()['userId'];
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Card(
                      color: Colors.orangeAccent,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text("${snapshot.data[index]
                                  .data()['noteName']}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text("${snapshot.data[index]
                                  .data()['noteText']}",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextButton(
                                            style: TextButton.styleFrom(
                                              minimumSize: Size(10, 10),
                                            ),
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 16.0,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                FirestoreApi().deleteData(snapshot.data[index].data(), currentTimeStamp, currentUserId); // referring to noteId
                                              });
                                            }
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text("${snapshot.data[index]
                                            .data()['timeStamp']}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
            );
          } else {
            return Center(
              child: Text("Loading...",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            );
          }
        }
    );
  }

  Future<Null> refreshPage() async {
    await Future.delayed(Duration(milliseconds: 100));
    return null;
  }

  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text("Notes List"),
          ),
        ),
        body: RefreshIndicator(
          key: refreshKey,
          child: showEntries(),
          onRefresh: () async {
            await refreshPage();
          },
        ),
      );
    }
}


