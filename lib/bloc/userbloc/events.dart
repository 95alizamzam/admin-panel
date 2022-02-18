abstract class UserEvents {}

class FetchAllUsers extends UserEvents {
  final String filter;
  FetchAllUsers(this.filter);
}
