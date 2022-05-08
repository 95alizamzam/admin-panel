import 'package:flutter/material.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';

class PackageInfoItem extends StatefulWidget {
  final packageInfoTitle;
  final packageInfoValue;
  final width;
  final isEnabled;
  final onSaved;
  final onValidate;

  PackageInfoItem({required this.packageInfoTitle, this.width, required this.packageInfoValue, required this.isEnabled, required this.onSaved, this.onValidate});
  @override
  _PackageInfoItemState createState() => _PackageInfoItemState();
}

class _PackageInfoItemState extends State<PackageInfoItem> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    textEditingController.text = widget.packageInfoValue.toString();
    super.initState();
  }
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 120,
      child: TextFormField(
        controller: textEditingController,
       // initialValue: '${widget.packageInfoValue}',
        enabled: widget.isEnabled,
        style: widget.isEnabled ? Constants.TEXT_STYLE4 : Constants.TEXT_STYLE4.copyWith(color: MyColors.grey),
        keyboardType: TextInputType.number,
        validator: widget.onValidate ?? (userInput){
          if(userInput!.isEmpty)
            return 'Please enter a value';
          else {
            try {
              int.parse(userInput);
              return null;
            } catch (e) {
              return 'Please enter a valid value';
            }
          }
        },
        onSaved: widget.onSaved,
        decoration: InputDecoration(
          labelText: widget.packageInfoTitle,
          labelStyle: Constants.TEXT_STYLE9,
          enabledBorder: Constants.outlineBorder.copyWith(
            borderSide: BorderSide(color: MyColors.secondaryColor, width: 2),
          ),
          errorBorder: Constants.outlineBorder,
          focusedBorder: Constants.outlineBorder,
          disabledBorder: Constants.outlineBorder,
        ),
      ),
    );
  }
}
