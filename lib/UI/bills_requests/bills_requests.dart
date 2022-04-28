import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:marketing_admin_panel/UI/bills_requests/widgets/requested_bill_item.dart';
import 'package:marketing_admin_panel/bloc/bills_bloc/bills_bloc.dart';
import 'package:marketing_admin_panel/bloc/bills_bloc/events.dart';
import 'package:marketing_admin_panel/bloc/bills_bloc/states.dart';
import 'package:marketing_admin_panel/models/bill_model.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';

class BillsRequests extends StatefulWidget {
  @override
  State<BillsRequests> createState() => _BillsRequestsState();
}

class _BillsRequestsState extends State<BillsRequests> {
  @override
  void initState() {
    BlocProvider.of<BillsBloc>(context).add(FetchBillsRequests());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, left: 12, top: 12),
      child: BlocConsumer<BillsBloc, BillState>(
        listener: (ctx, state){
          if(state is DeleteBillRequestLoading)
            EasyLoading.show(status: 'Please wait..');
          else if(state is DeleteBillRequestFailed)
            EasyLoading.showError(state.message);
          else if(state is DeleteBillRequestSucceed)
            EasyLoading.showSuccess('Done');
        },
        builder: (ctx, state) {
          if (state is BillRequestsLoading)
            return Center(
                child: CircularProgressIndicator(
                  color: MyColors.secondaryColor,
                ));
          else if (state is BillRequestsFailed)
            return Center(
              child: Text(
                state.message,
                style: Constants.TEXT_STYLE9,
              ),
            );
          else {
            List<OneBillModel> requestedBills = context.read<BillsBloc>().requestedBills;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(
                      'Requested Bills',
                      style: Constants.TEXT_STYLE2
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    CircleAvatar(
                      backgroundColor: MyColors.lightGrey,
                      child: Text(
                        '${requestedBills.length}',
                        style: Constants.TEXT_STYLE9.copyWith(
                          color: MyColors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12,),
                Expanded(
                  child: ListView.separated(
                    itemCount: requestedBills.length,
                    separatorBuilder: (ctx, index) => const SizedBox(height: 12,),
                    itemBuilder: (ctx, index) => RequestedBillItem(bill: requestedBills[index]),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

