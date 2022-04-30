import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:marketing_admin_panel/models/offers_model.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:marketing_admin_panel/utils/enums.dart';

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

  List<OneOfferModel> filterPrices(
      List<OneOfferModel> offers, double minPrice, double maxPrice) {
    List<String> offersToRemove = [];

    for (var offer in offers) {
      if (offer.offerType == OfferType.Product.toString()) {
        OneProductModel p = offer as OneProductModel;
        bool isInRange = true;

        for (var productProp in p.properties!) {
          for (var size in productProp.sizes!) {
            if (!(size.price! > minPrice && size.price! < maxPrice)) {
              isInRange = false;
              break;
            }
          }

          //check if already found a price not in range, if there is one, no need to continue
          if (!isInRange) break;
        }

        if (!isInRange) offersToRemove.add(p.id!);
      }
    }

    offers.removeWhere((offer) => offersToRemove.contains(offer.id));

    return offers;
  }

  List<OneOfferModel> filterCategories(List<OneOfferModel> offers, List<String> categories) {
    List<String> offersToRemove = [];

    for (var offer in offers) {
      if (offer.offerType == OfferType.Product.toString()) {
        OneProductModel p = offer as OneProductModel;
        bool isThereMatch = false;

        for (var category in p.categories!) {
          if (categories.contains(category)) {
            isThereMatch = true;
            break;
          }
        }

        if (!isThereMatch) offersToRemove.add(p.id!);
      }
    }

    offers.removeWhere((offer) => offersToRemove.contains(offer.id));
    return offers;
  }
}