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
import 'package:marketing_admin_panel/utils/modal_sheets.dart';
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
          ModalSheets().showSendPoints(context, controller, widget.userId);
        },
        icon: SvgPicture.asset(
          'assets/images/send_points.svg',
        ),
      ),
    );
  }
}
