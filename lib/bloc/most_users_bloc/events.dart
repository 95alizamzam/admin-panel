
abstract class MostUserEvents {}

class GetMostUser extends MostUserEvents {
  String userType;

  GetMostUser(this.userType);
}