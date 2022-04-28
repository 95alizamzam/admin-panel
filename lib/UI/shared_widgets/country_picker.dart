import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';

class CountryPicker extends StatelessWidget {
  final saveCountry;

  CountryPicker({
    required this.saveCountry,
  });
  @override
  Widget build(BuildContext context) {
    return CSCPicker(
      onCountryChanged: (val) {
        saveCountry(val);
      },
      onStateChanged: (val) {
        //print(val);
      },
      onCityChanged: (val) {
        //print(val);
      },
      //flagState: showFlag ? CountryFlag.ENABLE : CountryFlag.DISABLE,
      showStates: false,
      showCities: false,

      selectedItemStyle: Constants.TEXT_STYLE1,
      dropdownItemStyle: Constants.TEXT_STYLE1,
      dropdownHeadingStyle: Constants.TEXT_STYLE1,
      dropdownDecoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        color: MyColors.primaryColor,
        border: Border.all(color: MyColors.lightGrey, width: 2),
      ),
      disabledDropdownDecoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        color: MyColors.lightGrey,
        border: Border.all(color: MyColors.lightGrey, width: 2),
      ),
      dropdownDialogRadius: 16,
      searchBarRadius: 16,
      countryDropdownLabel: 'Country',
    );
  }
}
