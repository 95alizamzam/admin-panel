import 'package:bloc/bloc.dart';
import 'package:marketing_admin_panel/bloc/bills_bloc/events.dart';
import 'package:marketing_admin_panel/bloc/bills_bloc/states.dart';
import 'package:marketing_admin_panel/models/bill_model.dart';
import 'package:marketing_admin_panel/repositories/bills/bills_repo.dart';

import '../../locator.dart';

class BillsBloc extends Bloc<BillEvent, BillState> {
  List<OneBillModel> requestedBills = [];
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
      } else if(event is DeleteBillRequest){
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
    });
  }
}
