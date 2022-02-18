import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/bloc/userbloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/userbloc/events.dart';
import 'package:marketing_admin_panel/bloc/userbloc/states.dart';
import 'package:marketing_admin_panel/models/usersModel.dart';

import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/navigator/named_routes.dart';
import 'package:marketing_admin_panel/utils/navigator/navigator_imp.dart';

import 'most_row_elements.dart';
import 'users_list.dart';

class UsersTab extends StatefulWidget {
  const UsersTab({Key? key}) : super(key: key);

  @override
  State<UsersTab> createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    BlocProvider.of<UserBloc>(context).add(FetchAllUsers('UserType.Person'));
    super.didChangeDependencies();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      padding: const EdgeInsets.only(right: 10, top: 20, bottom: 20),
      color: MyColors.primaryColor,
      child: Column(
        children: [
          SizedBox(
            child: Form(
              key: formKey,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Empty Field';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: MyColors.lightBlue,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: MyColors.secondaryColor,
                    ),
                  ),
                  hintText: 'Enter User Name Or Email',
                  filled: true,
                  fillColor: MyColors.primaryColor,
                  hintStyle: const TextStyle(
                    color: MyColors.lightBlue,
                  ),
                ),
                onFieldSubmitted: (String? value) {
                  if (!formKey.currentState!.validate()) {
                    return;
                  } else {
                    formKey.currentState!.save();
                    // do the search process
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  BlocBuilder<UserBloc, UserStates>(builder: (context, state) {
                    if (state is UserDoneState) {
                      OneUserModel mostBuy = state.model.allusers.first;
                      return Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  navigatorImp().push(NamedRoutes.UserDetails,
                                      arguments: {
                                        'user': mostBuy,
                                      });
                                },
                                child: RowElement(
                                  label: 'The most Buy',
                                  userImage: mostBuy.profileImage!,
                                  userName: mostBuy.userName!,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            const Expanded(
                              child: RowElement(
                                label: 'The most Buy',
                                userImage:
                                    'https://th.bing.com/th/id/R.3282eea20bca492fee1217a9e67bdcb9?rik=nEoqljJB8%2fSl%2fw&pid=ImgRaw&r=0',
                                userName: 'Ali Zamzam',
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
                  const UsersList(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
