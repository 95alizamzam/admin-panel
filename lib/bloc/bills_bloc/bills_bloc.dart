import 'package:bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/bills_bloc/events.dart';
import 'package:marketing_admin_panel/bloc/bills_bloc/states.dart';
import 'package:marketing_admin_panel/models/bill_model.dart';
import 'package:marketing_admin_panel/repositories/bills/bills_repo.dart';
import '../../locator.dart';

class BillsBloc extends Bloc<BillEvent, BillState> {
  List<OneBillModel> requestedBills = [];

  int getUnDeliveredBills(){
    List<OneBillModel> bills = requestedBills.where((bill) => bill.isDelivered == false).toList();
    return bills.length;
  }

  List<OneBillModel> getTodayBills(){
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return requestedBills.where((bill) {
      final dateToCheck = DateTime(bill.date!.year, bill.date!.month, bill.date!.day);
      if(dateToCheck == today)
        return true;
      else return false;
    }).toList();

  }

  List<OneBillModel> getYesterdayBills(){
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    return requestedBills.where((bill) {
      final dateToCheck = DateTime(bill.date!.year, bill.date!.month, bill.date!.day);
      if(dateToCheck == yesterday)
        return true;
      else return false;
    }).toList();

  }

  List<OneBillModel> getWeekAgoBills(){
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final weekAgo = DateTime(now.year, now.month, now.day - 7);

    return requestedBills.where((bill) {
      final dateToCheck = DateTime(bill.date!.year, bill.date!.month, bill.date!.day);
      if(dateToCheck.isBefore(yesterday) && (dateToCheck.isAfter(weekAgo) || dateToCheck == weekAgo))
        return true;
      else return false;
    }).toList();

  }

  List<OneBillModel> getOlderBills(){
    final now = DateTime.now();
    final lastWeek = DateTime(now.year, now.month, now.day - 7);

    return requestedBills.where((bill) {
      final dateToCheck = DateTime(bill.date!.year, bill.date!.month, bill.date!.day);
      if(dateToCheck.isBefore(lastWeek))
        return true;
      else return false;
    }).toList();

  }

  BillsBloc() : super(BillInitialState()) {
    on<BillEvent>((event, emit) async {
      if(event is FetchBillsRequests){
        emit(BillRequestsLoading());
        try{
          requestedBills = await locator.get<BillsRepo>().fetchBillsRequests();

          emit(BillRequestsFetched());
        }catch (e){
          emit(BillRequestsFailed('Error Occurred, please try again.'));
        }
      }

      else if(event is DeleteBillRequest){
        emit(DeleteBillRequestLoading());
        try{
          await locator.get<BillsRepo>().deleteBillRequest(event.billId);
          requestedBills.removeWhere((request)  {
            return request.id == event.billId;
          });
          emit(DeleteBillRequestSucceed());
        }catch (e){
          emit(DeleteBillRequestFailed('Error Occurred, please try again.'));
        }
      }

      else if(event is MarkBillAsDelivered){
        emit(MarkBillAsDeliveredLoading());
        try{
          await locator.get<BillsRepo>().markBillAsDelivered(event.billId);

          //update fetched data
          OneBillModel oneBillModel = requestedBills[requestedBills.indexWhere((bill) => bill.id == event.billId)];
          oneBillModel.isDelivered = true;

          requestedBills[requestedBills.indexWhere((bill) => bill.id == event.billId)] = oneBillModel;

          emit(MarkBillAsDeliveredDone());
        }catch (e){
          emit(MarkBillAsDeliveredFailed('Error Occurred, please try again.'));
        }
      }
    });
  }
}
