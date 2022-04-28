
class PointsState {}

class PointsInitialState extends PointsState {}

class SendPointsLoading extends PointsState {}

class SendPointsFailed extends PointsState {
  String message;

  SendPointsFailed(this.message);
}

class SendPointsSucceed extends PointsState {}