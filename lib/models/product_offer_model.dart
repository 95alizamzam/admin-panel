import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsOffersModel {
  List<OneProductOfferModel> allProductsOffers = [];
  ProductsOffersModel.fromJson(List<dynamic> data) {
    data.forEach((element) {
      allProductsOffers.add(OneProductOfferModel.fromJson(element.data()));
    });
  }
}

class OneProductOfferModel {
  List<dynamic> categories = [];
  List<dynamic> comments = [];
  List<dynamic> likes = [];
  List<dynamic> offerMedia = [];
  dynamic offerName;
  dynamic offerOwnerId;
  dynamic offerOwnerType;
  dynamic offerType;
  Timestamp? offerCreationDate;
  dynamic vat;
  dynamic status;
  dynamic shortDesc;
  Map<String, dynamic> shippingCosts = {};
  List<dynamic> properties = [];

  dynamic discount;
  dynamic discountExpireDate;
  bool? isReturnAvailable;
  bool? isShippingFree;

  OneProductOfferModel.fromJson(Map<String, dynamic> json) {
    categories = json['categories'];
    comments = json['comments'];
    likes = json['likes'];
    offerMedia = json['offerMedia'];

    offerName = json['offerName'];
    offerOwnerId = json['offerOwnerId'];
    offerOwnerType = json['offerOwnerType'];
    offerType = json['offerType'];
    offerCreationDate = json['offerCreationDate'];

    vat = json['vat'];
    status = json['status'];
    shortDesc = json['shortDesc'];

    discount = json['discount'];
    discountExpireDate = json['discountExpireDate'];
    isReturnAvailable = json['isReturnAvailable'];
    isShippingFree = json['isShippingFree'];

    shippingCosts = json['shippingCosts'];
    properties = json['properties'];
  }
}
