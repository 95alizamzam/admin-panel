import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/bloc/userbloc/events.dart';
import 'package:marketing_admin_panel/bloc/userbloc/states.dart';
import 'package:marketing_admin_panel/locator.dart';
import 'package:marketing_admin_panel/models/usersModel.dart';
import 'package:marketing_admin_panel/repositories/users/user_repo.dart';
import 'dart:convert';

class UserBloc extends Bloc<UserEvents, UserStates> {
  UserBloc() : super(UserInitialState()) {
    on<UserEvents>((event, emit) async {
      if (event is FetchAllUsers) {
        emit(UserLoadingState());

        try {
          final data = await locator.get<UserRepo>().getAllUsers();
          UsersModel model = UsersModel.fromJson(data.docs);

          emit(UserDoneState(model));
        } catch (e) {
          print(e.toString());
          emit(UserFiledState());
        }
      }
    });
  }
}
