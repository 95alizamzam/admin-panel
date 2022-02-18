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
    required double width,
  }) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Container(
        alignment: Alignment.center,
        width: width,
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

  static Image defaultImage() {
    return Image.asset(
      'images/default_user_image.png',
      fit: BoxFit.cover,
      width: 120,
      height: 120,
    );
  }
}
