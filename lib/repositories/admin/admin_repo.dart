
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminRepo {
  Future<void> signInAdmin(String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      String adminId = credential.user!.uid;
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('admin').doc(adminId).get();
      if(!documentSnapshot.exists)
        throw 'not admin';
    } on FirebaseAuthException catch (e) {
      throw e.code;
    } catch (e) {
      throw e;
    }
  }

}