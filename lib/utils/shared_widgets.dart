import 'package:flutter/cupertino.dart';
import 'package:marketing_admin_panel/utils/colors.dart';

class SharedWidgets {
  static Widget customButton({
    required Function ontap,
    required String buttonLabel,
    required double padding,
    required double radius,
    required Color labelColor,
    required double labelSize,
  }) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: MyColors.lightBlue,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Text(
          buttonLabel,
          style: TextStyle(
            color: labelColor,
            fontSize: labelSize,
          ),
        ),
      ),
    );
  }
}
