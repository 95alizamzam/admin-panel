import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepo {
  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers({
    required String filter,
  }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    final users = await firestore
        .collection('users')
        .where('userType', isEqualTo: filter)
        .orderBy('points', descending: true)
        .get();

    return users;
  }
}
