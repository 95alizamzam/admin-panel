import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketing_admin_panel/models/bill_model.dart';

class BillsRepo {
  Future<List<OneBillModel>> fetchBillsRequests() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      List<OneBillModel> bills = [];
      final query = await firestore.collection('bills requests').get();

      for (var q in query.docs) {
        String billId = q.data()['billId'];
        String userId = q.data()['userId'];

        final documentSnapshot = await firestore
            .collection('users')
            .doc(userId)
            .collection('bills')
            .doc(billId)
            .get();
        OneBillModel bill =
            OneBillModel.fromJson(documentSnapshot.data()!, billId);
        bills.add(bill);
      }

      bills.sort((a, b) {
        return a.date!.compareTo(b.date!);
      });
      return bills;
    } catch (e) {
      print('error is $e');
      throw e;
    }
  }

  Future<void> deleteBillRequest(String billId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore
          .collection('bills requests')
          .where('billId', isEqualTo: billId)
          .get()
          .then((snapshot) {
        for (var s in snapshot.docs) s.reference.delete();
      });
    } catch (e) {
      print('error is $e');
      throw e;
    }
  }
}
