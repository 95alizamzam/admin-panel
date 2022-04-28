import 'package:flutter/material.dart';
import 'package:marketing_admin_panel/UI/shared_widgets/default_image.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';
import 'package:marketing_admin_panel/utils/navigator/named_routes.dart';
import 'package:marketing_admin_panel/utils/navigator/navigator_imp.dart';

class RowElement extends StatelessWidget {
  const RowElement({Key? key, required this.label, required this.user})
      : super(key: key);

  final String label;
  final user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.lightBlue.withOpacity(0.2),
      ),
      child: user == null ? Container() : Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            style: Constants.TEXT_STYLE8,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                NavigatorImpl().push(NamedRoutes.UserDetails, arguments: {'user': user});
              },
              child: Row(
                children: [
                  user == null
                      ? DefaultImage(
                          size: 60.0,
                        )
                      : user?.profileImage == ''
                          ? DefaultImage(
                              size: 60.0,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image(
                                image: NetworkImage(user!.profileImage!),
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                  const SizedBox(width: 10),
                  Text(
                    user?.userName! ?? '',
                    style: Constants.TEXT_STYLE4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
