import 'package:cloud_firestore/cloud_firestore.dart';

class OffersRepo {
// get all added categories

  Future<QuerySnapshot<Map<String, dynamic>>> getAllOffers() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final offers = firestore.collection('offers').get();
    return offers;
  }
}
