
class AdminState {}

class AdminStateInitialized extends AdminState {}

class AdminSignInLoading extends AdminState {}

class AdminSignInSuccess extends AdminState {}

class AdminSignInFailed extends AdminState {
  String message;

  AdminSignInFailed(this.message);
}