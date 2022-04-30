import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:marketing_admin_panel/UI/shared_widgets/country_picker.dart';
import 'package:marketing_admin_panel/UI/shared_widgets/custom_button.dart';
import 'package:marketing_admin_panel/UI/shared_widgets/custom_filter_container.dart';
import 'package:marketing_admin_panel/UI/shared_widgets/custom_text_form_field.dart';
import 'package:marketing_admin_panel/UI/users_person_tab/widgets/gender_picker.dart';
import 'package:marketing_admin_panel/bloc/category_bloc/change_bloc.dart';
import 'package:marketing_admin_panel/bloc/category_bloc/events.dart';
import 'package:marketing_admin_panel/bloc/category_bloc/states.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/offers_bloc/events.dart';
import 'package:marketing_admin_panel/bloc/points_bloc/points_bloc.dart';
import 'package:marketing_admin_panel/bloc/points_bloc/points_events.dart';
import 'package:marketing_admin_panel/bloc/users_bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/users_bloc/events.dart';
import 'package:provider/src/provider.dart';
import '../helper.dart';
import 'colors.dart';
import 'constants.dart';
import 'enums.dart';
import 'package:flutter/material.dart';
import 'navigator/navigator_imp.dart';

class ModalSheets {

  void showUsersFilter(BuildContext context, UserType userType) {
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
                  if (userType == UserType.User)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Age',
                        style: Constants.TEXT_STYLE4,
                      ),
                    ),
                  if (userType == UserType.User)
                    const SizedBox(
                      height: 8,
                    ),
                  if (userType == UserType.User)
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
                  if (userType == UserType.User)
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

  void showSendPoints(BuildContext context, TextEditingController controller, String userId) {
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
                    'Enter amount',
                    style: Constants.TEXT_STYLE4,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomTextFormField(
                    controller: controller,
                    hint: 'Enter points amount',
                    width: 300.0,
                    keyboardType: TextInputType.number,
                    validateInput: (p) {},
                    saveInput: (p) {},
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomButton(
                    ontap: () {
                      if (controller.text.isEmpty)
                        EasyLoading.showToast('Enter points');
                      else {
                        int points = int.tryParse(controller.text) ?? 0;
                        if (points <= 0)
                          EasyLoading.showToast('Enter points');
                        else {
                          context.read<PointsBloc>().add(SendPoints(userId, points));
                          NavigatorImpl().pop();
                        }
                      }
                    },
                    buttonLabel: 'Send',
                    padding: 12,
                    radius: 12,
                    color: MyColors.secondaryColor,
                    labelColor: Colors.white,
                    labelSize: 16,
                    width: 300,
                  ),
                  Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom)),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void showOfferFilter(BuildContext context, UserType userType, OfferType offerType) {
    //data to filter
    RangeValues val = RangeValues(0, 10000);
    String? status = '';
    List<String> categories = [];
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
                  if (offerType == OfferType.Product)
                    RangeSlider(
                      labels: RangeLabels(val.start.ceil().toString(), val.end.ceil().toString()),
                      divisions: 10000,
                      activeColor: MyColors.secondaryColor,
                      inactiveColor: MyColors.lightGrey,
                      min: 0,
                      max: 10000,
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
                  if (offerType == OfferType.Product)
                    GestureDetector(
                      onTap: () async {
                        //showFilterCountriesSheet(context, countries);
                        ctx.read<CategoryBloc>().add(FetchAllCategoriesEvent());
                        showCategoriesPicker(context, categories);
                      },
                      child: CustomFilterContainer(
                        title: 'Categories',
                      ),
                    ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () async {
                      //showFilterCountriesSheet(context, countries);
                      showFilterCountriesSheet(context, countries);
                    },
                    child: CustomFilterContainer(
                      title: 'Countries',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  if (offerType == OfferType.Product)
                    GestureDetector(
                      onTap: () async {
                        status = await showModalBottomSheet<String>(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          context: context,
                          builder: (ctx) => SafeArea(
                            child: Container(
                              child: Wrap(
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                      'New',
                                      style: Constants.TEXT_STYLE3,
                                    ),
                                    trailing: status ==
                                        OfferStatus.New.toString()
                                        ? Icon(
                                      Icons.done,
                                      size: 20,
                                      color: MyColors.secondaryColor,
                                    )
                                        : CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                    ),
                                    onTap: () {
                                      // setNewState(() {
                                      //   status = OfferStatus.New.toString();
                                      // });
                                      NavigatorImpl().pop(result: OfferStatus.New.toString());
                                    },
                                  ),
                                  ListTile(
                                    title: Text(
                                      'Used',
                                      style: Constants.TEXT_STYLE3,
                                    ),
                                    trailing: status ==
                                        OfferStatus.Used.toString()
                                        ? Icon(
                                      Icons.done,
                                      size: 20,
                                      color: MyColors.secondaryColor,
                                    )
                                        : CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                    ),
                                    onTap: () {
                                      // setNewState(() {
                                      //   status = OfferStatus.Used.toString();
                                      // });
                                      NavigatorImpl().pop(result: OfferStatus.Used.toString());
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        );
                      },
                      child: CustomFilterContainer(
                        title: 'Status',
                      ),
                    ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomButton(
                    ontap: () {
                      ctx.read<OfferBloc>().add(FilterOffers(val.start, val.end, status ?? '', categories, countries, offerType, userType));
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

  showCategoriesPicker(BuildContext context, List<String> categories) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      context: context,
      builder: (_) => BlocBuilder<CategoryBloc, CategoryStates>(
        builder: (_, state) {
          if (state is FetchAllCategoriesLoadingStates)
            return Center(child: CircularProgressIndicator());
          else if (state is FetchAllCategoriesDoneStates)
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Categories',
                    style: Constants.TEXT_STYLE2.copyWith(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.model.cats.length,
                      itemBuilder: (ctx, index) => InkWell(
                        onTap: () async {
                          showSubCategoriesPicker(context, categories, state.model.cats[index].subCategories, state.model.cats[index].title ?? '');
                        },
                        child: ListTile(
                          title: Text(
                            state.model.cats[index].title ?? '',
                            style: Constants.TEXT_STYLE3,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                            color: MyColors.secondaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        NavigatorImpl().pop();
                      },
                      child: Text(
                        'Ok',
                        style: Constants.TEXT_STYLE3,
                      ),
                    ),
                  ),
                ],
              ),
            );
          else if (state is FetchAllCategoriesFailedStates)
            return Center(
              child: Text(
                state.message,
                style: Constants.TEXT_STYLE1,
              ),
            );
          else
            return Container();
        },
      ),
    );
  }

  showSubCategoriesPicker(BuildContext context, List<String> categories, List<dynamic> subCategories, String categoryName) async {
    showModalBottomSheet(
        isDismissible: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        context: context,
        builder: (ctx) => StatefulBuilder(
              builder: (ctx, setNewState) => Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      categoryName,
                      style: Constants.TEXT_STYLE2.copyWith(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: subCategories.length,
                        itemBuilder: (ctx, index) => InkWell(
                          onTap: () {
                            setNewState(() {
                              categories.contains(subCategories[index])
                                  ? categories.remove(subCategories[index])
                                  : categories.add(subCategories[index]);
                            });
                          },
                          child: ListTile(
                            title: Text(
                              subCategories[index] ?? '',
                              style: Constants.TEXT_STYLE3,
                            ),
                            trailing: categories.contains(subCategories[index])
                                ? Icon(
                                    Icons.done,
                                    size: 20,
                                    color: MyColors.secondaryColor,
                                  )
                                : Icon(
                                    Icons.close,
                                    size: 20,
                                    color: MyColors.secondaryColor,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          NavigatorImpl().pop();
                        },
                        child: Text(
                          'Ok',
                          style: Constants.TEXT_STYLE3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  // showStatusPicker(BuildContext context, String status) {
  //
  // }
}
