import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/UI/bills_requests/bills_requests.dart';
import 'package:marketing_admin_panel/UI/c_offers_tab/c_offers_tab.dart';
import 'package:marketing_admin_panel/UI/categories_tab/categories_tab.dart';
import 'package:marketing_admin_panel/UI/currencies/currencies_tab.dart';
import 'package:marketing_admin_panel/UI/offers_tab/offers_tab.dart';
import 'package:marketing_admin_panel/UI/users_company_tab/companies_tab.dart';
import 'package:marketing_admin_panel/UI/users_person_tab/users_tab.dart';
import 'package:marketing_admin_panel/utils/colors.dart';

class MiddlePart extends StatefulWidget {
  final PageController pageController;

  MiddlePart({
    required this.pageController,
  });

  @override
  State<MiddlePart> createState() => _MiddlePartState();
}

class _MiddlePartState extends State<MiddlePart> {
  List<Widget> tabs = [
    UsersTab(),
    CompaniesTap(),
    CategoriesTab(),
    OffersTab(),
    COffersTab(),
    CurrenciesTab(),
    BillsRequests(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: widget.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: tabs,
    );
  }
}
