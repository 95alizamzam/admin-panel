import 'package:cloud_firestore/cloud_firestore.dart';

class OffersModel {
  final List<OneProductModel> productOffers = [];
  final List<OneImageModel> imageOffers = [];
  final List<OneVideoModel> videoOffers = [];
  final List<OnePostModel> postOffers = [];
  OffersModel.fromJson(List<dynamic> data) {
    data.forEach((element) {
      if(element.data()['offerType'] == 'OfferType.Product')
        productOffers.add(OneProductModel.fromJson(element.data(), element.id));
      else if(element.data()['offerType']  == 'OfferType.Post')
        postOffers.add(OnePostModel.fromJson(element.data(), element.id));
      else if(element.data()['offerType']  == 'OfferType.Image')
        imageOffers.add(OneImageModel.fromJson(element.data(), element.id));
      else if(element.data()['offerType']  == 'OfferType.Video')
        videoOffers.add(OneVideoModel.fromJson(element.data(), element.id));
    });
  }
}

class OneOfferModel {
  String? id;
  List<dynamic> comments = [];
  List<dynamic> likes = [];
  List<dynamic> offerMedia = [];
  dynamic offerOwnerId;
  dynamic offerOwnerType;
  dynamic offerType;
  DateTime? offerCreationDate;

  OneOfferModel.fromJson(Map<String, dynamic> json, String offerId) {
    id = offerId;
    comments = json['comments'];
    likes = json['likes'];
    offerMedia = json['offerMedia'];
    offerOwnerId = json['offerOwnerId'];
    offerOwnerType = json['offerOwnerType'];
    offerType = json['offerType'];
    offerCreationDate = (json['offerCreationDate'] as Timestamp).toDate();
  }
}

class OneProductModel extends OneOfferModel {
  List<dynamic> categories = [];
  dynamic offerName;
  dynamic vat;
  dynamic status;
  dynamic shortDesc;
  Map<String, dynamic>? shippingCosts = {};
  List<dynamic> properties = [];
  dynamic discount;
  dynamic discountExpireDate;
  bool? isReturnAvailable;
  bool? isShippingFree;

  OneProductModel.fromJson(Map<String, dynamic> json, String offerId)
      : super.fromJson(json, offerId) {
    categories = json['categories'];
    offerName = json['offerName'];
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

class OneImageModel extends OneOfferModel {
  OneImageModel.fromJson(Map<String, dynamic> json, String offerId)
      : super.fromJson(json, offerId);
}

class OnePostModel extends OneOfferModel {
  String? shortDesc;

  OnePostModel.fromJson(Map<String, dynamic> json, String offerId)
      : super.fromJson(json, offerId) {
    shortDesc = json['shortDesc'];
  }
}

class OneVideoModel extends OneOfferModel {
  OneVideoModel.fromJson(Map<String, dynamic> json, String offerId)
      : super.fromJson(json, offerId);
}
