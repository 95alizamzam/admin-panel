import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/bloc/users_bloc/events.dart';
import 'package:marketing_admin_panel/bloc/users_bloc/states.dart';
import 'package:marketing_admin_panel/locator.dart';
import 'package:marketing_admin_panel/models/usersModel.dart';
import 'package:marketing_admin_panel/repositories/users/user_repo.dart';

class UserBloc extends Bloc<UserEvents, UserStates> {
  List<OneUserModel> users = [];

  //in case many requests sent at same time
  bool alreadyFetchingMoreUsers = false;

  UserBloc() : super(UserInitialState()) {
    on<UserEvents>((event, emit) async {
      if (event is FetchAllUsers) {
        emit(FetchUserLoadingState());
        try {
          users = await locator.get<UserRepo>().getAllUsers(event.userType);
          emit(FetchUserDoneState());
        } catch (e) {
          print(e.toString());
          emit(FetchUserFailedState('Network Error'));
        }
      }

      else if(event is FetchMoreUsers && !alreadyFetchingMoreUsers){
        alreadyFetchingMoreUsers = true;
        emit(FetchMoreUserLoadingState());
        try {
          List<OneUserModel> moreUsers = await locator.get<UserRepo>().getAllUsers(event.userType, lastFetchedDocument: event.lastFetchedDocument);
          users.addAll(moreUsers);
          alreadyFetchingMoreUsers = false;
          emit(FetchMoreUserDoneState());
        } catch (e) {
          alreadyFetchingMoreUsers = false;
          emit(FetchMoreUserFailedState('Network Error'));
        }
      }

      else if (event is DeleteUser) {
        emit(UserDeleteLoading());
        try {
          HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('deleteUser');
          final response = await callable.call(<String, dynamic>{
            'userId': event.uId,
            'userType': event.userType,
          });
          print(response.data);

          users.removeWhere((user) => user.id == event.uId);
          emit(UserDeleted());
        } catch (e) {
          emit(UserDeleteFailed('Delete Failed'));
        }
      }

      else if (event is SearchUsers) {
        emit(SearchLoading());
        try {
          users = await locator.get<UserRepo>().searchForUsers(event.searchType, event.searchText, event.userType);
          emit(SearchDone());
        } catch (e) {
          print('error is ${e.toString()}');
          emit(SearchFailed('Network Error'));
        }
      }
      
      else if(event is GetUserPackageName){
        emit(GetUserPackageNameLoading());
        try {
          String packageName = await locator.get<UserRepo>().getUserPackageName(event.userId);
          emit(GetUserPackageNameDone(packageName));
        } catch (e) {
          emit(GetUserPackageNameFailed('Network Error'));
        } 
      }

      else if (event is FilterUsers) {
        emit(FilterLoading());
        try {
          users = await locator.get<UserRepo>().filterUsers(event.minAge, event.maxAge, event.gender, event.countries, event.userType);
          emit(FilterDone());
        } catch (e) {
          print('error is ${e.toString()}');
          emit(FilterFailed('Network Error'));
        }
      }
    });
  }
}
