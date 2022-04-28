import 'package:flutter/material.dart';
import '../users_person_tab/widgets/users_page.dart';
import 'package:marketing_admin_panel/utils/enums.dart';

class CompaniesTap extends StatelessWidget {
  const CompaniesTap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UsersPage(userType: UserType.Company);
  }
}
