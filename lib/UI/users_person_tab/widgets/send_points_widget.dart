import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketing_admin_panel/UI/shared_widgets/custom_button.dart';
import 'package:marketing_admin_panel/UI/shared_widgets/custom_text_form_field.dart';
import 'package:marketing_admin_panel/bloc/points_bloc/points_bloc.dart';
import 'package:marketing_admin_panel/bloc/points_bloc/points_events.dart';
import 'package:marketing_admin_panel/bloc/points_bloc/points_states.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';
import 'package:marketing_admin_panel/utils/navigator/navigator_imp.dart';
import 'package:provider/src/provider.dart';

class SendPointsWidget extends StatefulWidget {
  final String userId;

  SendPointsWidget({required this.userId});
  @override
  _SendPointsWidgetState createState() => _SendPointsWidgetState();
}

class _SendPointsWidgetState extends State<SendPointsWidget> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<PointsBloc, PointsState>(
      listener: (ctx, state) {
        if(state is SendPointsLoading)
          EasyLoading.show(status: 'Please wait');
        else if(state is SendPointsFailed){
          EasyLoading.dismiss();
          EasyLoading.showError(state.message);
        }
        else if(state is SendPointsSucceed){
          EasyLoading.dismiss();
          EasyLoading.showSuccess('Done');
        }
      },
      child: IconButton(
        onPressed: () {
          showSendPoints(context, controller, widget.userId);
        },
        icon: SvgPicture.asset(
          'assets/images/send_points.svg',
        ),
      ),
    );
  }
}

void showSendPoints(BuildContext context, TextEditingController controller, String userId) {
  showModalBottomSheet(
    isScrollControlled: true,
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      borderSide: BorderSide(color: MyColors.primaryColor),
    ),
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Enter amount',
                  style: Constants.TEXT_STYLE4,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomTextFormField(
                  controller: controller,
                  hint: 'Enter points amount',
                  width: 300.0,
                  keyboardType: TextInputType.number,
                  validateInput: (p) {},
                  saveInput: (p) {},
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomButton(
                  ontap: () {
                    if(controller.text.isEmpty)
                      EasyLoading.showToast('Enter points');
                    else{
                      int points = int.tryParse(controller.text) ?? 0;
                      if(points <= 0)
                        EasyLoading.showToast('Enter points');
                      else{
                        context.read<PointsBloc>().add(SendPoints(userId, points));
                        NavigatorImpl().pop();
                      }
                    }
                  },
                  buttonLabel: 'Send',
                  padding: 12,
                  radius: 12,
                  color: MyColors.secondaryColor,
                  labelColor: Colors.white,
                  labelSize: 16,
                  width: 300,
                ),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(ctx).viewInsets.bottom)),
              ],
            ),
          );
        },
      );
    },
  );
}
