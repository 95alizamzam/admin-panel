import 'package:cloud_firestore/cloud_firestore.dart';

class CurrenciesRepo {
  Future<Map<String, double>> getCurrencies() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      final query = await firestore.collection('currencies').get();
      final data = query.docs.first.data().map((key, value) => MapEntry(key, double.parse(value.toString())));

      return data;
    } catch (e) {
      print('error is $e');
      throw e;
    }
  }

  Future<void> changeCurrencyValue(String currencyName, double currencyNewValue) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection('currencies').doc('currencies prices').update({
        currencyName: currencyNewValue,
      });
    } catch (e) {
      print('error is $e');
      throw e;
    }
  }

  Future<void> DeleteCurrency(String currencyName) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection('currencies').doc('currencies prices').update({
        currencyName: FieldValue.delete(),
      });
    } catch (e) {
      print('error is $e');
      throw e;
    }
  }

  Future<void> AddCurrency(String currencyName, double currencyValue) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection('currencies').doc('currencies prices').update({
        currencyName: currencyValue,
      });
    } catch (e) {
      print('error is $e');
      throw e;
    }
  }
}
