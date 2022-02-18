import 'package:marketing_admin_panel/models/usersModel.dart';

abstract class UserStates {}

class UserInitialState extends UserStates {}

class UserLoadingState extends UserStates {}

class UserDoneState extends UserStates {
  final UsersModel model;
  UserDoneState(this.model);
}

class UserFiledState extends UserStates {}
