import 'package:cloud_firestore/cloud_firestore.dart';

class ImagesOffer {
  List<OneImageOffer> allImageOffers = [];
  ImagesOffer.fromJson(List<dynamic> data) {
    data.forEach((element) {
      allImageOffers.add(OneImageOffer.fromJson(element.data()));
    });
  }
}

class OneImageOffer {
  List<dynamic> comments = [];
  List<dynamic> likes = [];
  List<dynamic> offerMedia = [];

  Timestamp? offerCreationDate;
  String? offerOwnerId;
  String? offerOwnerType;
  String? offerType;

  String? shortDesc;

  OneImageOffer.fromJson(Map<String, dynamic> json) {
    comments = json['comments'];
    likes = json['likes'];
    offerMedia = json['offerMedia'];
    offerCreationDate = json['offerCreationDate'];
    offerOwnerId = json['offerOwnerId'];
    offerOwnerType = json['offerOwnerType'];
    offerType = json['offerType'];
    shortDesc = json['shortDesc'] ?? '';
  }
}
