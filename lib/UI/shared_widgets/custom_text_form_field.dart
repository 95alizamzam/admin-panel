import 'package:flutter/material.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextFormField extends StatelessWidget {
  final controller;
  final hint;
  final icon;
  final keyboardType;
  final showPassword;
  final isPassword;
  final showPasswordFunction;
  final validateInput;
  final saveInput;
  final enabled;
  final onChanged;
  final initialValue;
  final width;

  CustomTextFormField({
    this.controller,
    required this.hint,
    this.icon,
    this.keyboardType,
    required this.width,
    this.showPassword = true,
    this.isPassword = false,
    this.showPasswordFunction,
    this.enabled = true,
    this.onChanged,
    this.initialValue,
    required this.validateInput,
    required this.saveInput,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        cursorColor: MyColors.secondaryColor,
        cursorWidth: 3,
        style: Constants.TEXT_STYLE1,
        keyboardType: keyboardType ?? TextInputType.text,
        obscureText: showPassword ? false : true,
        validator: validateInput,
        onSaved: saveInput,
        onChanged: onChanged,
        initialValue: initialValue,
        decoration: InputDecoration(
          contentPadding: icon != null
              ? const EdgeInsets.symmetric(vertical: 16)
              : const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          prefixIcon: icon != null
              ? SvgPicture.asset(
                  'assets/images/$icon.svg',
            fit: BoxFit.scaleDown,
                )
              : null,
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: showPasswordFunction,
                  icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                    color: MyColors.grey,
                  ),
                )
              : null,
          hintText: hint,
          errorStyle: TextStyle(
            fontWeight: FontWeight.w300,
            color: MyColors.red,
            fontSize: 12,
          ),
          hintStyle: Constants.TEXT_STYLE1,
          enabledBorder: Constants.outlineBorder,
          disabledBorder: Constants.outlineBorder,
          focusedBorder: Constants.outlineBorder,
          errorBorder: Constants.outlineBorder,
          focusedErrorBorder: Constants.outlineBorder,
        ),
      ),
    );
  }
}
