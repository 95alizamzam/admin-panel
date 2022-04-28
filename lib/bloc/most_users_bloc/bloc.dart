import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/bloc/most_users_bloc/events.dart';
import 'package:marketing_admin_panel/bloc/most_users_bloc/states.dart';
import 'package:marketing_admin_panel/locator.dart';
import 'package:marketing_admin_panel/models/usersModel.dart';
import 'package:marketing_admin_panel/repositories/users/user_repo.dart';

class MostUsersBloc extends Bloc<MostUserEvents, MostUsersStates> {

  //in case many requests sent at same time
  bool alreadyFetchingMoreUsers = false;

  MostUsersBloc() : super(MostUserInitialState()) {
    on<MostUserEvents>((event, emit) async {
      if (event is GetMostUser) {
        emit(GetMostUsersLoading());
        try {
          OneUserModel? mostInteractingUser = await locator.get<UserRepo>().getMostInteractingUser(event.userType);
          OneUserModel? mostPointsUser = await locator.get<UserRepo>().getMostPointsUser(event.userType);
          OneUserModel? mostOffersAddedUser = await locator.get<UserRepo>().getMostAddOffersUser(event.userType);
          emit(GetMostUsersDone(mostInteractingUser, mostPointsUser, mostOffersAddedUser));
        } catch (e) {
          print(e.toString());
          emit(GetMostUsersFailed('Network Error'));
        }
      }
    });
  }
}
