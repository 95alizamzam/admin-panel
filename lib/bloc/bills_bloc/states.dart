
class BillState {}

class BillInitialState extends BillState {}

class BillRequestsLoading extends BillState {}

class BillRequestsFetched extends BillState {}

class BillRequestsFailed extends BillState {
  String message;

  BillRequestsFailed(this.message);
}

class DeleteBillRequestLoading extends BillState {}

class DeleteBillRequestSucceed extends BillState {}

class DeleteBillRequestFailed extends BillState {
  String message;

  DeleteBillRequestFailed(this.message);
}



