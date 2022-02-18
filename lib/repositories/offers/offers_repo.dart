import 'package:cloud_firestore/cloud_firestore.dart';

class OffersRepo {
  Future<QuerySnapshot<Map<String, dynamic>>> getAllOffers(String type) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    return await firestore
        .collection('offers')
        .where('offerType', isEqualTo: type)
        .get();
  }
}
