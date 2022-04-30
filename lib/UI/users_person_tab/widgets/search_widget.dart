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
import 'package:marketing_admin_panel/utils/modal_sheets.dart';
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
            ModalSheets().showUsersFilter(context, widget.userType);
          },
          icon: SvgPicture.asset(
            'assets/images/filter.svg',
          ),
        ),
      ],
    );
  }
}