import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:marketing_admin_panel/UI/users_person_tab/user_details_screen.dart';
import 'user_info_row.dart';
import 'package:marketing_admin_panel/utils/colors.dart';

import '../../../helper.dart';

class AddressInfoRow extends StatelessWidget {
  final latitude, longitude;

  AddressInfoRow({required this.longitude, required this.latitude});

  @override
  Widget build(BuildContext context) {
    if (longitude == 0 && latitude == 0)
      return UserInfoRow(
        data: 'Not Provided',
        title: 'Address',
        icon: SvgPicture.asset(
          'assets/images/location.svg',
          color: MyColors.secondaryColor,
          fit: BoxFit.scaleDown,
        ),
      );
    return FutureBuilder(
      future: Helper().getUserAddress(latitude, longitude),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return RefreshProgressIndicator(
            color: MyColors.secondaryColor,
          );
        else {
          String address = 'Error, please refresh page';
          if(!snapshot.hasError){
            Placemark location = snapshot.data as Placemark;
            address = '${location.country} - ${location.administrativeArea} - ${location.subAdministrativeArea} - ${location.locality} - ${location.street}\nPostalCode: ${location.postalCode!.isEmpty ? 'No Code' : location.postalCode}';
          }
          return UserInfoRow(
            data: address,
            title: 'Address',
            icon: SvgPicture.asset(
              'assets/images/location.svg',
              fit: BoxFit.scaleDown,
              color: MyColors.secondaryColor,
            ),
            flexible: true,
          );
        }
      },
    );
  }
}