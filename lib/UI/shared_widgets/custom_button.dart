import 'package:flutter/material.dart';
import 'package:marketing_admin_panel/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final Function ontap;
  final String buttonLabel;
  final double padding;
  final double radius;
  final Color labelColor;
  final double labelSize;
  final double width;

  CustomButton({
    required this.ontap,
    required this.buttonLabel,
    required this.padding,
    required this.radius,
    required this.labelColor,
    required this.labelSize,
    required this.width,
});
  @override
  Widget build(BuildContext context) {
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
}
