import 'package:flutter/material.dart';
import 'widgets/users_page.dart';
import 'package:marketing_admin_panel/utils/enums.dart';

class UsersTab extends StatelessWidget {
  const UsersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UsersPage(userType: UserType.User);
  }
}
