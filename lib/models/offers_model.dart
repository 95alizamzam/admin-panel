import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marketing_admin_panel/models/product_property.dart';
import 'comment_model.dart';

class OneOfferModel {
  String? id;
  List<String>? offerMedia;
  String? offerType;
  String? offerOwnerType;
  String? offerOwnerId;
  DateTime? offerCreationDate;
  //a list contains users ids
  List<String>? likes;
  List<CommentModel>? comments;
  //this field is used to fetch offers by countries
  List<String>? countries;

  OneOfferModel({
    this.id,
    required this.offerMedia,
    required this.offerType,
    required this.offerOwnerType,
    required this.offerOwnerId,
    required this.offerCreationDate,
    required this.countries,
    this.comments,
    this.likes,
  });

  OneOfferModel.fromMap(Map<String, dynamic> offerInfo, String offerId) {
    this.id = offerId;
    this.offerMedia = (offerInfo['offerMedia'] as List<dynamic>)
        .map((e) => e.toString())
        .toList();
    this.offerType = offerInfo['offerType'];
    this.countries = ((offerInfo['countries'] ?? []) as List<dynamic>).map((e) => e.toString()).toList();
    this.offerOwnerType = offerInfo['offerOwnerType'];
    this.offerOwnerId = offerInfo['offerOwnerId'];
    this.offerCreationDate = (offerInfo['offerCreationDate'] as Timestamp).toDate();
    this.likes = (offerInfo['likes'] as List<dynamic>).map((e) => e.toString()).toList();
    this.comments = (offerInfo['comments'] as List<dynamic>)
        .map((e) => CommentModel.fromMap(e))
        .toList();
  }
}

class OneProductModel extends OneOfferModel {
  String? offerName;
  List<String>? categories;
  String? status;
  double? vat;
  double? discount;
  String? discountExpireDate;
  String? shortDesc;
  List<ProductProperty>? properties;
  Map<String, double>? shippingCosts;
  bool? isReturnAvailable;
  bool? isShippingFree;

  OneProductModel({
    id,
    required offerMedia,
    likes,
    required offerOwnerType,
    required offerOwnerId,
    required offerType,
    required offerCreationDate,
    required this.offerName,
    required this.categories,
    required this.status,
    required countries,
    this.vat = 0,
    this.discount = 0,
    this.discountExpireDate = '',
    this.shortDesc = '',
    required this.properties,
    this.shippingCosts,
    this.isShippingFree = false,
    this.isReturnAvailable = false,
    comments,
  }) : super(
    id: id,
    offerMedia: offerMedia,
    likes: likes,
    countries: countries,
    offerCreationDate: offerCreationDate,
    offerType: offerType,
    offerOwnerType: offerOwnerType,
    offerOwnerId: offerOwnerId,
    comments: comments,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'offerMedia': offerMedia,
    'offerOwnerType': offerOwnerType,
    'offerOwnerId': offerOwnerId,
    'offerName': offerName,
    'offerCreationDate': offerCreationDate,
    'offerType': offerType,
    'categories': categories,
    'status': status,
    'vat': vat,
    'countries': countries,
    'discount': discount,
    'discountExpireDate': discountExpireDate,
    'shortDesc': shortDesc,
    'properties': properties!.map((e) => e.toMap()).toList(),
    'shippingCosts': shippingCosts,
    'isShippingFree': isShippingFree,
    'isReturnAvailable': isReturnAvailable,
    'likes': likes,
    'comments': comments,
  };

  OneProductModel.fromMap(Map<String, dynamic> offerInfo, String offerId)
      : super.fromMap(offerInfo, offerId) {
    this.offerName = offerInfo['offerName'];
    this.categories = (offerInfo['categories'] as List<dynamic>)
        .map((e) => e.toString())
        .toList();
    this.status = offerInfo['status'];
    this.vat = offerInfo['vat'];
    this.discount = offerInfo['discount'];
    this.discountExpireDate = offerInfo['discountExpireDate'];
    this.shortDesc = offerInfo['shortDesc'];
    this.properties = (offerInfo['properties'] as List<dynamic>)
        .map((e) => ProductProperty(
        color: Color(e['color']),
        sizes: (e['sizes'] as List<dynamic>)
            .map((e) => ProductSize(size: e['size'], price: e['price']))
            .toList()))
        .toList();
    this.shippingCosts =
        (offerInfo['shippingCosts'] as Map<String, dynamic>).map((key, value) {
          return MapEntry(key, value);
        });
    this.isReturnAvailable = offerInfo['isReturnAvailable'];
    this.isShippingFree = offerInfo['isShippingFree'];
  }
}

class OnePostModel extends OneOfferModel {
  String? shortDesc;

  OnePostModel({
    id,
    offerMedia,
    likes,
    comments,
    required offerOwnerType,
    required offerOwnerId,
    required offerCreationDate,
    required countries,
    required offerType,
    required this.shortDesc,
  }) : super(
    id: id,
    offerMedia: offerMedia,
    offerType: offerType,
    likes: likes,
    countries: countries,
    offerCreationDate: offerCreationDate,
    offerOwnerType: offerOwnerType,
    offerOwnerId: offerOwnerId,
    comments: comments,
  );

  Map<String, dynamic> toMap() => {
    'offerMedia': offerMedia,
    'offerOwnerType': offerOwnerType,
    'offerOwnerId': offerOwnerId,
    'offerCreationDate': offerCreationDate,
    'offerType': offerType,
    'shortDesc': shortDesc,
    'countries': countries,
    'likes': likes,
    'id': id,
    'comments': comments,
  };

  OnePostModel.fromMap(Map<String, dynamic> offerInfo, String offerId)
      : super.fromMap(offerInfo, offerId) {
    this.shortDesc = offerInfo['shortDesc'];
  }
}

class OneImageModel extends OneOfferModel {
  OneImageModel({
    id,
    likes,
    comments,
    required offerMedia,
    required offerOwnerType,
    required offerOwnerId,
    required offerCreationDate,
    required offerType,
    required countries,
  }) : super(
    id: id,
    likes: likes,
    offerMedia: offerMedia,
    offerType: offerType,
    countries: countries,
    offerOwnerType: offerOwnerType,
    offerCreationDate: offerCreationDate,
    offerOwnerId: offerOwnerId,
    comments: comments,
  );

  Map<String, dynamic> toMap() => {
    'offerMedia': offerMedia,
    'offerOwnerType': offerOwnerType,
    'offerOwnerId': offerOwnerId,
    'offerCreationDate': offerCreationDate,
    'offerType': offerType,
    'id': id,
    'countries': countries,
    'likes': likes,
    'comments': comments,
  };

  OneImageModel.fromMap(Map<String, dynamic> offerInfo, String offerId)
      : super.fromMap(offerInfo, offerId);
}

class OneVideoModel extends OneOfferModel {
  OneVideoModel({
    id,
    likes,
    comments,
    required offerMedia,
    required offerOwnerType,
    required offerOwnerId,
    required offerCreationDate,
    required offerType,
    required countries,
  }) : super(
    id: id,
    likes: likes,
    offerMedia: offerMedia,
    offerType: offerType,
    countries: countries,
    offerOwnerType: offerOwnerType,
    offerCreationDate: offerCreationDate,
    offerOwnerId: offerOwnerId,
    comments: comments,
  );

  Map<String, dynamic> toMap() => {
    'offerMedia': offerMedia,
    'offerOwnerType': offerOwnerType,
    'offerCreationDate': offerCreationDate,
    'offerOwnerId': offerOwnerId,
    'offerType': offerType,
    'id': id,
    'likes': likes,
    'comments': comments,
    'countries': countries,
  };

  OneVideoModel.fromMap(Map<String, dynamic> offerInfo, String offerId)
      : super.fromMap(offerInfo, offerId);
}



// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class OffersModel {
//   final List<OneProductModel> productOffers = [];
//   final List<OneImageModel> imageOffers = [];
//   final List<OneVideoModel> videoOffers = [];
//   final List<OnePostModel> postOffers = [];
//   OffersModel.fromJson(List<dynamic> data) {
//     data.forEach((element) {
//       if(element.data()['offerType'] == 'OfferType.Product')
//         productOffers.add(OneProductModel.fromJson(element.data(), element.id));
//       else if(element.data()['offerType']  == 'OfferType.Post')
//         postOffers.add(OnePostModel.fromJson(element.data(), element.id));
//       else if(element.data()['offerType']  == 'OfferType.Image')
//         imageOffers.add(OneImageModel.fromJson(element.data(), element.id));
//       else if(element.data()['offerType']  == 'OfferType.Video')
//         videoOffers.add(OneVideoModel.fromJson(element.data(), element.id));
//     });
//   }
// }
//
// class OneOfferModel {
//   String? id;
//   List<dynamic> comments = [];
//   List<dynamic> likes = [];
//   List<dynamic> offerMedia = [];
//   dynamic offerOwnerId;
//   dynamic offerOwnerType;
//   dynamic offerType;
//   DateTime? offerCreationDate;
//
//   OneOfferModel.fromJson(Map<String, dynamic> json, String offerId) {
//     id = offerId;
//     comments = json['comments'];
//     likes = json['likes'];
//     offerMedia = json['offerMedia'];
//     offerOwnerId = json['offerOwnerId'];
//     offerOwnerType = json['offerOwnerType'];
//     offerType = json['offerType'];
//     offerCreationDate = (json['offerCreationDate'] as Timestamp).toDate();
//   }
// }
//
// class OneProductModel extends OneOfferModel {
//   List<dynamic> categories = [];
//   dynamic offerName;
//   dynamic vat;
//   dynamic status;
//   dynamic shortDesc;
//   Map<String, dynamic>? shippingCosts = {};
//   List<dynamic> properties = [];
//   dynamic discount;
//   dynamic discountExpireDate;
//   bool? isReturnAvailable;
//   bool? isShippingFree;
//
//   OneProductModel.fromJson(Map<String, dynamic> json, String offerId)
//       : super.fromJson(json, offerId) {
//     categories = json['categories'];
//     offerName = json['offerName'];
//     vat = json['vat'];
//     status = json['status'];
//     shortDesc = json['shortDesc'];
//     discount = json['discount'];
//     discountExpireDate = json['discountExpireDate'];
//     isReturnAvailable = json['isReturnAvailable'];
//     isShippingFree = json['isShippingFree'];
//     shippingCosts = json['shippingCosts'];
//     properties = json['properties'];
//   }
// }
//
// class OneImageModel extends OneOfferModel {
//   OneImageModel.fromJson(Map<String, dynamic> json, String offerId)
//       : super.fromJson(json, offerId);
// }
//
// class OnePostModel extends OneOfferModel {
//   String? shortDesc;
//
//   OnePostModel.fromJson(Map<String, dynamic> json, String offerId)
//       : super.fromJson(json, offerId) {
//     shortDesc = json['shortDesc'];
//   }
// }
//
// class OneVideoModel extends OneOfferModel {
//   OneVideoModel.fromJson(Map<String, dynamic> json, String offerId)
//       : super.fromJson(json, offerId);
// }
