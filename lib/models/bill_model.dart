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

  OneBillModel.fromJson(Map<String, dynamic> json, String billId) {
    id = billId;
    date = (json['date'] as Timestamp).toDate();
    amount = json['amount'];
    productName = json['productName'];
    productPrice = json['productPrice'];
    productColor = Color(json['productColor']);
    productSize = json['productSize'];
    vat = json['vat'];
    shippingCost = json['shippingCost'];
    shipTo = json['shipTo'];
    buyerName = json['buyerName'];
    buyerEmail = json['buyerEmail'];
    buyerPhoneNumber = json['buyerPhoneNumber'];
    buyerCountry = json['buyerCountry'];
    buyerCity = json['buyerCity'];
    buyerLongitude = json['buyerLongitude'];
    buyerLatitude = json['buyerLatitude'];
  }
}