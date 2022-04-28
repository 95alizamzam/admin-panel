import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:flutter/material.dart';

class Helper {

  void customizeEasyLoading() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.doubleBounce
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 50.0
      ..radius = 10.0
      ..displayDuration = Duration(milliseconds: 1500)
      ..backgroundColor = MyColors.lightBlue
      ..progressColor = MyColors.primaryColor
      ..indicatorColor = MyColors.primaryColor
      ..textColor = MyColors.primaryColor
      ..maskColor = MyColors.red
      ..userInteractions = false
      ..contentPadding = EdgeInsets.symmetric(horizontal: 25, vertical: 16)
      ..toastPosition = EasyLoadingToastPosition.bottom
      ..textStyle = TextStyle(
        color: MyColors.primaryColor,
        fontWeight: FontWeight.w300,
        fontSize: 16,
      );
  }

  Future<Placemark> getUserAddress(double latitude, double longitude) async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(latitude, longitude);

      Placemark place = placeMarks[0];

      return place;
    }catch (e) {
      throw e;
    }
  }

  dynamic roundPrice(dynamic price){
    if(price is double)
      return double.parse(price.toStringAsFixed(2));

    else return price;
  }

  String getCountryFlag(String country){
    if(country == 'All countries')
      return country;

    return country.replaceAll(RegExp('[A-Za-z0-9]'), '').trim();
  }

  String deleteCountryFlag(String country){
    if(country == 'All countries')
      return country;

    return country.replaceAll(RegExp('[^A-Za-z0-9 ]'), '').trimLeft();
  }

  int getAgeFromBirthDate(String birthDate){

    if(birthDate.isEmpty)
      return 0;

    //get year from string formatted like: 17-07-1995
    int yearOfBirth = int.parse(birthDate.substring(6));
    //get current year
    int currentYear = DateTime.now().year;

    return currentYear - yearOfBirth;
  }
}