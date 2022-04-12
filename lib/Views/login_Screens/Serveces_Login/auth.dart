import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String resultId;


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future signInWithEmailAndPassword(String email, String password) async {
     AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
     resultId = result.user.uid ;
     return result;
  }

  Future signUpWithEmailAndPassword(String email, String password , String name) async {
    AuthResult result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    if(result != null)
    {
      Firestore.instance.collection('Users').document(result.user.uid).setData({
        'Name':name,
        'Email':email,
        'Password':password,
        'id':result.user.uid,
        "photoUrl":"",
      });
      resultId=result.user.uid;
      return result;
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

