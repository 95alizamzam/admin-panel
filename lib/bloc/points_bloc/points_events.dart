

class PointsEvent {}

class SendPoints extends PointsEvent {
  String userId;
  int amount;

  SendPoints(this.userId, this.amount);

}