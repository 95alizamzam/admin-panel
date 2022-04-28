import 'package:flutter/material.dart';
import 'package:marketing_admin_panel/UI/shared_widgets/default_image.dart';
import 'package:marketing_admin_panel/models/usersModel.dart';
import 'package:marketing_admin_panel/repositories/users/user_repo.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';
import 'package:marketing_admin_panel/utils/navigator/named_routes.dart';
import 'package:marketing_admin_panel/utils/navigator/navigator_imp.dart';

class OwnerRow extends StatelessWidget {
  final id;

  OwnerRow({required this.id});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserRepo().getUserById(id),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return LinearProgressIndicator(
            color: MyColors.secondaryColor,
          );
        else if (snapshot.hasError)
          return Text('Error, please refresh page');
        else {
          final user = snapshot.data as OneUserModel;
          return InkWell(
            onTap: () {
              NavigatorImpl().push(NamedRoutes.UserDetails, arguments: {
                'user': user,
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  user.profileImage == null || user.profileImage == ''
                      ? DefaultImage(size: 50.0)
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      user.profileImage!,
                      fit: BoxFit.cover,
                      width: 50.0,
                      height: 50.0,
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Text(
                    user.userName!,
                    style: Constants.TEXT_STYLE4,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
