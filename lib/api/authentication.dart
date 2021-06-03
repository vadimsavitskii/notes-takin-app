
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

Future<UserCredential> anonymousLoginOrGetUser() async {
 return await auth.signInAnonymously();
}

bool checkUserIsLogged() {
  return auth.currentUser != null;
}

