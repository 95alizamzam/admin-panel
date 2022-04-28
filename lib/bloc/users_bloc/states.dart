import 'package:marketing_admin_panel/models/usersModel.dart';

abstract class UserStates {}

class UserInitialState extends UserStates {}

class FetchUserLoadingState extends UserStates {}

class FetchUserDoneState extends UserStates {}

class FetchUserFailedState extends UserStates {
  String message;

  FetchUserFailedState(this.message);
}

class FetchMoreUserLoadingState extends UserStates {}

class FetchMoreUserDoneState extends UserStates {}

class FetchMoreUserFailedState extends UserStates {
  String message;

  FetchMoreUserFailedState(this.message);
}

class UserDeleteLoading extends UserStates {}

class UserDeleted extends UserStates {}

class UserDeleteFailed extends UserStates {
  String message;

  UserDeleteFailed(this.message);
}

class SearchLoading extends UserStates {}

class SearchDone extends UserStates {}

class SearchFailed extends UserStates {
  String message;

  SearchFailed(this.message);
}

class FilterLoading extends UserStates {}

class FilterDone extends UserStates {}

class FilterFailed extends UserStates {
  String message;

  FilterFailed(this.message);
}

class GetUserPackageNameLoading extends UserStates {}

class GetUserPackageNameDone extends UserStates {
  String packageName;

  GetUserPackageNameDone(this.packageName);
}

class GetUserPackageNameFailed extends UserStates {
  String message;

  GetUserPackageNameFailed(this.message);
}

