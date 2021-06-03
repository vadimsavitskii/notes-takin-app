

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_final_project/api/authentication.dart';

class FirestoreApi {
  FirebaseFirestore firestore;

  init() {
    firestore = FirebaseFirestore.instance;
  }

  Future<DocumentReference> addData(Map<String, dynamic> data) async {
    init();
    DocumentReference ref = await firestore.collection('notes').add(data);
    return ref;
  }

  Future<List<Map<String, dynamic>>> readAllData() async {
    init();
    QuerySnapshot snapshot = await firestore.collection('notes').get();
    List<Map<String, dynamic>> notes = snapshot.docs.map<Map<String, dynamic>>((e) => e.data()).toList();
    return notes;
  }

  Future getPosts() async {
    init();
    String userId = (await anonymousLoginOrGetUser()).user.uid;
    QuerySnapshot qn = await firestore.collection('notes').where('userId', isEqualTo: userId).get();
    return qn.docs;
  }

  // For user access testing:
  // Future getPostsTest() async {
  //   init();
  //   QuerySnapshot qn = await firestore.collection('notes').get();
  //   return qn.docs;
  // }

  Future<DocumentReference> deleteData(Map<String, dynamic> data, timeStamp, userId) async {
    // ignore: missing_return
    init();
    String userId = (await anonymousLoginOrGetUser()).user.uid;
    await firestore.collection('notes').where('userId', isEqualTo: userId).where('timeStamp', isEqualTo: timeStamp).get()
        .then((value){
          value.docs.forEach((element) {
            firestore.collection('notes').doc(element.id).delete().then((value){
              print('Value deleted');
        });
      });
    });
  }

}
