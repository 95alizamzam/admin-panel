import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketing_admin_panel/UI/shared_widgets/default_image.dart';
import 'package:marketing_admin_panel/UI/users_person_tab/widgets/send_points_widget.dart';
import 'package:marketing_admin_panel/bloc/users_bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/users_bloc/events.dart';
import 'package:marketing_admin_panel/bloc/users_bloc/states.dart';
import 'package:marketing_admin_panel/models/usersModel.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';
import 'package:marketing_admin_panel/utils/enums.dart';
import 'package:marketing_admin_panel/utils/navigator/named_routes.dart';
import 'package:marketing_admin_panel/utils/navigator/navigator_imp.dart';

class UsersList extends StatefulWidget {
  const UsersList({Key? key, required this.userType}) : super(key: key);

  final UserType userType;

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  final scrollController = ScrollController();
  //for pagination
  String _lastFetchedUserId = '';

  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(FetchAllUsers(widget.userType.toString()));
    scrollController.addListener(() {
      if (scrollController.offset >= scrollController.position.maxScrollExtent && !scrollController.position.outOfRange) {
        context.read<UserBloc>().add(FetchMoreUsers(widget.userType.toString(), _lastFetchedUserId));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserStates>(
      listener: (ctx, state) {
        if(state is UserDeleteLoading)
          EasyLoading.show(status: 'Please wait');
        else if(state is UserDeleted){
          EasyLoading.dismiss();
          EasyLoading.showSuccess('User deleted');
        }
        else if(state is UserDeleteFailed){
          EasyLoading.dismiss();
          EasyLoading.showError('Error occurred');
        }
      },
      builder: (ctx, state) {
        if (state is FetchUserFailedState)
          return Center(
            child: Text(
              state.message,
              style: Constants.TEXT_STYLE4,
              textAlign: TextAlign.center,
            ),
          );
        else if (state is FetchUserLoadingState || state is UserInitialState || state is SearchLoading || state is FilterLoading)
          return Center(
            child: CircularProgressIndicator(
              color: MyColors.secondaryColor,
            ),
          );
        else if(state is SearchFailed)
          return Center(
            child: Text(
              state.message,
              style: Constants.TEXT_STYLE4,
              textAlign: TextAlign.center,
            ),
          );
        else if(state is FilterFailed)
          return Center(
            child: Text(
              state.message,
              style: Constants.TEXT_STYLE4,
              textAlign: TextAlign.center,
            ),
          );
        else {
          List<OneUserModel> users = context.read<UserBloc>().users;
          if (users.isEmpty)
            return Center(
              child: Text(
                'No users yet',
                style: Constants.TEXT_STYLE9,
              ),
            );
          else {
            _lastFetchedUserId = users.last.id ?? '';
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    controller: scrollController,
                    itemBuilder: (context, index) => Container(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          NavigatorImpl().push(NamedRoutes.UserDetails, arguments: {'user': users[index]});
                        },
                        child: Row(
                          children: [
                            users[index].profileImage == ''
                                ? DefaultImage(
                                    size: 60.0,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image(
                                      image: NetworkImage(users[index].profileImage!),
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                            Expanded(
                              child: ListTile(
                                title: Text('${users[index].userName}'),
                                subtitle: Text('${users[index].nickName}'),
                              ),
                            ),
                            if(users[index].userType != UserType.Guest.toString())
                              SendPointsWidget(userId: users[index].id!),
                            GestureDetector(
                              onTap: () async {
                                bool b = await showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text(
                                      'Are you sure?',
                                      style: Constants.TEXT_STYLE8,
                                    ),
                                    content: Text(
                                      'User and his data will be deleted',
                                      style: Constants.TEXT_STYLE4.copyWith(color: Colors.red),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          NavigatorImpl().pop(result: false);
                                        },
                                        child: Text(
                                          'No',
                                          style: TextStyle(color: MyColors.secondaryColor),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          NavigatorImpl().pop(result: true);
                                        },
                                        child: Text(
                                          'Yes',
                                          style: TextStyle(color: MyColors.secondaryColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                );

                                if (b)
                                  BlocProvider.of<UserBloc>(context).add(
                                    DeleteUser(users[index].id!, users[index].userType!),
                                  );
                              },
                              child: SvgPicture.asset('assets/images/trash.svg'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemCount: users.length,
                  ),
                ),
                state is FetchMoreUserLoadingState
                    ? Center(
                      child: RefreshProgressIndicator(
                          color: MyColors.secondaryColor,
                        ),
                    )
                    : state is FetchMoreUserFailedState
                        ? Center(
                            child: Text(
                              state.message,
                              style: Constants.TEXT_STYLE6,
                              textAlign: TextAlign.center,
                            ),
                          )
                        : Container(),
              ],
            );
          }
        }
      },
    );
  }
}
