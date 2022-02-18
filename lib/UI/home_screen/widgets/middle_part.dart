import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/UI/categories_tab/categories_tab.dart';
import 'package:marketing_admin_panel/UI/offers_tab/offers_tab.dart';
import 'package:marketing_admin_panel/UI/users_company_tab/companies.dart';
import 'package:marketing_admin_panel/UI/users_person_tab/users_tab.dart';
import 'package:marketing_admin_panel/bloc/changeLeftPart/bloc.dart';
import 'package:marketing_admin_panel/bloc/changeLeftPart/states.dart';
import 'package:marketing_admin_panel/utils/colors.dart';

class MiddlePart extends StatelessWidget {
  List<Widget> tabs = [
    const UsersTab(),
    const CompaniesUsers(),
    const CategoriesTab(),
    const OffersTab(),
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
        return Expanded(
          flex: 3,
          child: Container(
            color: MyColors.lightGrey,
            child: tabs[currentIndex],
          ),
        );
      },
    );
  }
}
