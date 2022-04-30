import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketing_admin_panel/UI/offers_tab/widgets/offers_bar.dart';
import 'package:marketing_admin_panel/utils/enums.dart';

class OffersTab extends StatelessWidget {
  const OffersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OffersBar(offerOwnerType: UserType.User);
  }
}
