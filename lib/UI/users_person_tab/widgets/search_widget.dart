import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:marketing_admin_panel/UI/shared_widgets/country_picker.dart';
import 'package:marketing_admin_panel/UI/shared_widgets/custom_button.dart';
import 'package:marketing_admin_panel/UI/shared_widgets/custom_filter_container.dart';
import 'package:marketing_admin_panel/bloc/users_bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/users_bloc/events.dart';
import 'package:marketing_admin_panel/helper.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';
import 'package:marketing_admin_panel/utils/enums.dart';
import 'package:marketing_admin_panel/utils/navigator/navigator_imp.dart';

import 'gender_picker.dart';

class SearchWidget extends StatefulWidget {
  final UserType userType;

  SearchWidget({required this.userType});

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController searchController = TextEditingController();
  Color searchIconColor = MyColors.lightGrey;
  SearchType currentValue = SearchType.Username;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: searchController,
            cursorColor: MyColors.secondaryColor,
            cursorWidth: 3,
            style: Constants.TEXT_STYLE1,
            onChanged: (userInput) {
              if (userInput.isEmpty)
                setState(() {
                  searchIconColor = MyColors.lightGrey;
                });
              else
                setState(() {
                  searchIconColor = MyColors.secondaryColor;
                });
            },
            onFieldSubmitted: (userInput) {
              if (userInput.isEmpty || userInput.length < 4)
                EasyLoading.showError('Enter 4 characters at least');
              else
                BlocProvider.of<UserBloc>(context).add(SearchUsers(currentValue, userInput, widget.userType.toString()));
            },
            decoration: InputDecoration(
              prefixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                  color: searchIconColor,
                ),
                onPressed: () {
                  if (searchController.text.isEmpty || searchController.text.length < 4)
                    EasyLoading.showError('Enter 4 characters at least');
                  else
                    BlocProvider.of<UserBloc>(context).add(SearchUsers(currentValue, searchController.text, widget.userType.toString()));
                },
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: DropdownButton<SearchType>(
                  onChanged: (userInput) {
                    setState(() {
                      currentValue = userInput ?? SearchType.Username;
                    });
                  },
                  value: currentValue,
                  items: [
                    DropdownMenuItem(
                      child: Text('Username'),
                      value: SearchType.Username,
                    ),
                    DropdownMenuItem(
                      child: Text('User Code'),
                      value: SearchType.UserCode,
                    ),
                    DropdownMenuItem(
                      child: Text('Email'),
                      value: SearchType.Email,
                    ),
                  ],
                  style: Constants.TEXT_STYLE9.copyWith(fontWeight: FontWeight.w400),
                  underline: DropdownButtonHideUnderline(
                    child: Container(),
                  ),
                ),
              ),
              enabledBorder: Constants.outlineBorder,
              disabledBorder: Constants.outlineBorder,
              focusedBorder: Constants.outlineBorder,
              errorBorder: Constants.outlineBorder,
              focusedErrorBorder: Constants.outlineBorder,
              hintText: 'Enter User Name Or Email Or User Code',
              hintStyle: Constants.TEXT_STYLE1.copyWith(color: MyColors.lightGrey),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            showFilter(context, widget.userType);
          },
          icon: SvgPicture.asset(
            'assets/images/filter.svg',
          ),
        ),
      ],
    );
  }
}

void showFilter(BuildContext context, UserType userType) {
  //data to filter
  RangeValues val = RangeValues(0, 100);
  String gender = '';
  List<String> countries = [];

  showModalBottomSheet(
    isScrollControlled: true,
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      borderSide: BorderSide(color: MyColors.primaryColor),
    ),
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Filter',
                  style: Constants.TEXT_STYLE9,
                ),
                const SizedBox(
                  height: 12,
                ),
                if(userType == UserType.User)
                  Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Age',
                    style: Constants.TEXT_STYLE4,
                  ),
                ),
                if(userType == UserType.User)
                  const SizedBox(
                  height: 8,
                ),
                if(userType == UserType.User)
                  RangeSlider(
                  labels: RangeLabels(val.start.ceil().toString(), val.end.ceil().toString()),
                  divisions: 100,
                  activeColor: MyColors.secondaryColor,
                  inactiveColor: MyColors.lightGrey,
                  min: 0,
                  max: 100,
                  values: val,
                  onChanged: (rangeValues) {
                    setState(() {
                      val = rangeValues;
                    });
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () async {
                    showFilterCountriesSheet(context, countries);
                  },
                  child: CustomFilterContainer(
                    title: 'Countries',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                if(userType == UserType.User)
                  GenderPicker(
                  onSaved: (c) {},
                  onChanged: (pickedGender) {
                    gender = pickedGender;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomButton(
                  ontap: () {
                    context.read<UserBloc>().add(FilterUsers(val.start, val.end, gender, countries, userType));
                    NavigatorImpl().pop();
                  },
                  buttonLabel: 'Submit',
                  padding: 12,
                  radius: 12,
                  color: MyColors.secondaryColor,
                  labelColor: Colors.white,
                  labelSize: 16,
                  width: 300,
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

void showFilterCountriesSheet(BuildContext context, List<String> countries) {

  showModalBottomSheet(
    isScrollControlled: true,
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      borderSide: BorderSide(color: MyColors.primaryColor),
    ),
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setNewState) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Countries',
                style: TextStyle(
                  fontSize: 20,
                  color: MyColors.secondaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Pick countries to filter',
                  style: Constants.TEXT_STYLE4,
                ),
              ),
              CountryPicker(
                saveCountry: (val) {
                  String country = Helper().deleteCountryFlag(val);
                  countries.add(country);
                },
              ),
              const SizedBox(
                height: 8,
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: countries
                    .map(
                      (country) => Text(
                    '$country',
                    style: Constants.TEXT_STYLE4,
                  ),
                )
                    .toList(),
              ),
              const SizedBox(
                height: 8,
              ),
              CustomButton(
                ontap: () {
                  NavigatorImpl().pop();
                },
                buttonLabel: 'Add',
                padding: 12,
                radius: 12,
                color: MyColors.secondaryColor,
                labelColor: Colors.white,
                labelSize: 16,
                width: 300,
              ),
            ],
          ),
        ),
      );
    },
  );
}