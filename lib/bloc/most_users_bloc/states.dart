import 'package:marketing_admin_panel/models/usersModel.dart';

abstract class MostUsersStates {}

class MostUserInitialState extends MostUsersStates {}

class GetMostUsersLoading extends MostUsersStates {}

class GetMostUsersDone extends MostUsersStates {
  OneUserModel? mostInteractingUser;
  OneUserModel? mostPointsUser;
  OneUserModel? mostOffersAddedUser;

  GetMostUsersDone(this.mostInteractingUser, this.mostPointsUser, this.mostOffersAddedUser);
}

class GetMostUsersFailed extends MostUsersStates {
  String message;

  GetMostUsersFailed(this.message);
}
