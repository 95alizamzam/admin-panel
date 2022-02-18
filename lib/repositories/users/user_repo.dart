import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepo {
// get all added categories

  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final users = firestore.collection('users').get();
    return users;
  }
}
