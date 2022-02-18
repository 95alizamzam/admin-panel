import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/UI/shared_widgets/default_image.dart';
import 'package:marketing_admin_panel/bloc/userbloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/userbloc/states.dart';
import 'package:marketing_admin_panel/models/usersModel.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/navigator/named_routes.dart';
import 'package:marketing_admin_panel/utils/navigator/navigator_imp.dart';
import 'package:marketing_admin_panel/utils/shared_widgets.dart';

class UsersList extends StatelessWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserStates>(
      builder: (context, state) {
        if (state is UserDoneState) {
          List<OneUserModel> users = state.model.allusers;
          return Expanded(
            flex: 2,
            child: SizedBox(
              width: double.maxFinite,
              child: ListView.separated(
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    navigatorImp().push(NamedRoutes.UserDetails,
                        arguments: {'user': users[index]});
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.grey.shade300,
                          child: users[index].profileImage == ''
                              ? DefaultImage()
                              : Image.network(users[index].profileImage.toString())),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(users[index].userName.toString()),
                              const SizedBox(height: 4),
                              Text(users[index].nickName.toString()),
                              Text(users[index].shortDesc.toString()),
                            ],
                          ),
                        ),
                        const Icon(Icons.more_vert),
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: users.length,
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: MyColors.primaryColor,
            ),
          );
        }
      },
    );
  }
}
