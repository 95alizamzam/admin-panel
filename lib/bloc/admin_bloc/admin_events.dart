
class AdminEvent {}

class SignInAdmin extends AdminEvent {
  String email;
  String password;

  SignInAdmin(this.email, this.password);
}