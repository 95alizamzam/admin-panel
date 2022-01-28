import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/UI/home_screen/widgets/Tabs/categories_tab.dart';
import 'package:marketing_admin_panel/UI/home_screen/widgets/Tabs/offers_tab.dart';
import 'package:marketing_admin_panel/UI/home_screen/widgets/Tabs/user_tab/users_tab.dart';
import 'package:marketing_admin_panel/bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/states.dart';
import 'package:marketing_admin_panel/utils/colors.dart';

class MiddlePart extends StatelessWidget {
  List<Widget> tabs = [
    UsersTab(),
    const CategoriesTab(),
    const OffersTab(),
    const CategoriesTab(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PanelBloc, PanelStates>(
      listener: (context, state) {
        if (state is PanelChangeBodyDoneState) {
          currentIndex = state.selectedIndex;
        }
      },
      builder: (context, state) {
        if (state is PanelChangeBodyDoneState) {
          return Expanded(
            flex: 3,
            child: Container(
              color: MyColors.lightGrey,
              child: tabs[currentIndex],
            ),
          );
        } else {
          return Expanded(
            flex: 3,
            child: Container(
              color: MyColors.lightGrey,
              child: tabs[0],
            ),
          );
        }
      },
    );
  }
}
