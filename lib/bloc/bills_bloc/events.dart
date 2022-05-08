

class BillEvent {}

class FetchBillsRequests extends BillEvent {}

class DeleteBillRequest extends BillEvent {
  String billId;

  DeleteBillRequest(this.billId);
}

class MarkBillAsDelivered extends BillEvent{
  String billId;

  MarkBillAsDelivered(this.billId,);
}