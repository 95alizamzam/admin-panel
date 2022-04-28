import 'package:flutter/material.dart';
import 'most_row_elements.dart';
import 'package:marketing_admin_panel/models/usersModel.dart';

class MostUsersWidget extends StatelessWidget {
  final mostInteractingUser;
  final mostPointsUser;
  final mostOffersAddedUser;

  MostUsersWidget({required this.mostOffersAddedUser, required this.mostPointsUser, required this.mostInteractingUser});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RowElement(
            label: 'Most Interacting User',
            user: mostInteractingUser,
          ),
        ),
        Expanded(
          child: RowElement(
            label: 'Most Points User',
            user: mostPointsUser,
          ),
        ),
        Expanded(
          child: RowElement(
            label: 'Most Offers Added User',
            user: mostOffersAddedUser,
          ),
        ),
      ],
    );
  }
}
