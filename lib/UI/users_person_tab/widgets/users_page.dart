import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/UI/users_person_tab/widgets/search_widget.dart';
import 'users_list.dart';
import 'package:marketing_admin_panel/bloc/most_users_bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/most_users_bloc/events.dart';
import 'package:marketing_admin_panel/bloc/most_users_bloc/states.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';
import 'package:marketing_admin_panel/utils/enums.dart';

import 'most_users_widget.dart';

class UsersPage extends StatefulWidget {
  final UserType userType;

  UsersPage({required this.userType});
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  void initState() {
    BlocProvider.of<MostUsersBloc>(context).add(GetMostUser(widget.userType.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: SearchWidget(userType: widget.userType,),
          ),
          Expanded(
            flex: 2,
            child: BlocBuilder<MostUsersBloc, MostUsersStates>(
              builder: (ctx, state) {
                if(state is GetMostUsersFailed)
                  return Center(child: Text(state.message, style: Constants.TEXT_STYLE4, textAlign: TextAlign.center,),);

                else if(state is GetMostUsersDone)
                  return MostUsersWidget(
                    mostInteractingUser: state.mostInteractingUser,
                    mostOffersAddedUser: state.mostOffersAddedUser,
                    mostPointsUser: state.mostPointsUser,
                  );

                else
                  return Center(child: CircularProgressIndicator(color: MyColors.secondaryColor,),);
              },
            ),
          ),
          Expanded(
            flex: 6,
            child: UsersList(userType: widget.userType),
          ),
        ],
      ),
    );
  }
}
