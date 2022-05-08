import 'package:flutter/material.dart';
import 'package:marketing_admin_panel/UI/bills_requests/widgets/requested_bill_item.dart';
import 'package:marketing_admin_panel/models/bill_model.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';


class BillsExpansionList extends StatelessWidget {
  final text;
  final List<OneBillModel> bills;

  BillsExpansionList({required this.bills, required this.text});
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(text, style: Constants.TEXT_STYLE4,),
      iconColor: MyColors.secondaryColor,
      collapsedIconColor: MyColors.grey,
      initiallyExpanded: true,
      children: bills.map((bill) => RequestedBillItem(bill: bill)).toList(),
    );
  }
}
