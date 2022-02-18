import 'dart:convert';

class UsersModel {
  List<OneUserModel> allusers = [];
  UsersModel.fromJson(List<dynamic> list) {
    for (var element in list) {
      allusers.add(OneUserModel.fromJson(element.data()));
    }
  }
}

class OneUserModel {
  List<dynamic>? comments = [];
  List<dynamic>? offersLiked = [];

  String? country;
  String? dateBirth;

  String? gender;
  String? city;
  String? nickName;
  double? latitude;
  double? longitude;

  List<dynamic>? offersAdded = [];
  String? userName;
  String? userCode;
  dynamic? points;
  String? password;
  dynamic? phoneNumber;
  String? shortDesc;
  String? email;
  String? userType;
  String? profileImage;

  OneUserModel.fromJson(Map<String, dynamic> json) {
    comments = json['comments'];

    dateBirth = json['dateBirth'];
    profileImage = json['profileImage'] ?? '';

    country = json['country'];
    gender = json['gender'];

    city = json['city'];
    nickName = json['nickName'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    userName = json['userName'];
    userCode = json['userCode'];
    points = json['points'] ?? 0;
    password = json['password'];
    shortDesc = json['shortDesc'];

    phoneNumber = json['phoneNumber'];
    email = json['email'];
    userType = json['userType'].split('.').last;
    offersAdded = json['offersAdded'];
    offersLiked = json['offersLiked'];
  }
}
