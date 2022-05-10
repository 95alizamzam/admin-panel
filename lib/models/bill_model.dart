import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';

class OneBillModel {
  String? id;
  DateTime? date;
  dynamic amount;
  String? productName;
  dynamic productPrice;
  Color? productColor;
  String? productSize;
  dynamic vat;
  dynamic shippingCost;
  String? shipTo;
  String? buyerName;
  String? buyerEmail;
  String? buyerPhoneNumber;
  String? buyerCountry;
  String? buyerCity;
  dynamic buyerLongitude;
  dynamic buyerLatitude;
  bool? isRequested;
  bool? isDelivered;

  //user data
  String? userName;
  String? userEmail;
  String? userPhoneNumber;
  String? userCountry;
  String? userCity;
  dynamic userLongitude;
  dynamic userLatitude;

  OneBillModel.fromJson(Map<String, dynamic> billMap, Map<String, dynamic> userMap, String billId) {
    userName = userMap['userName'] ?? '';
    userEmail = userMap['email'] ?? '';
    userPhoneNumber = userMap['phoneNumber'] ?? '';
    userCountry = userMap['country'] ?? '';
    userCity = userMap['city'] ?? '';
    userLongitude = userMap['longitude'] ?? 0;
    userLatitude = userMap['latitude'] ?? 0;

    id = billId;
    date = (billMap['date'] as Timestamp).toDate();
    amount = billMap['amount'];
    productName = billMap['productName'];
    productPrice = billMap['productPrice'];
    productColor = Color(billMap['productColor']);
    productSize = billMap['productSize'];
    vat = billMap['vat'];
    shippingCost = billMap['shippingCost'];
    shipTo = billMap['shipTo'];
    buyerName = billMap['buyerName'];
    buyerEmail = billMap['buyerEmail'];
    buyerPhoneNumber = billMap['buyerPhoneNumber'];
    buyerCountry = billMap['buyerCountry'];
    buyerCity = billMap['buyerCity'];
    buyerLongitude = billMap['buyerLongitude'];
    buyerLatitude = billMap['buyerLatitude'];
    isRequested = billMap['isRequested'];
    isDelivered = billMap['isDelivered'];
  }
}