import 'package:flutter/material.dart';
import 'package:marketing_admin_panel/UI/offers_tab/widgets/offers_bar.dart';

class COffersTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return OffersBar(offerOwnerType: 'UserType.Company');
  }
}
