import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';

class GenderPicker extends StatefulWidget {
  final onSaved;
  final onChanged;

  GenderPicker({required this.onSaved, this.onChanged});
  @override
  _GenderPickerState createState() => _GenderPickerState();
}

class _GenderPickerState extends State<GenderPicker> {
  List<String> _genderList = ['Gender' ,'Male', 'Female'];
  String _chosenGender = 'Gender';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      style: Constants.TEXT_STYLE1,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        prefixIcon: SvgPicture.asset('assets/images/person.svg', fit: BoxFit.scaleDown,),
        enabledBorder: Constants.outlineBorder,
        focusedBorder: Constants.outlineBorder,
        errorBorder: Constants.outlineBorder,
        focusedErrorBorder: Constants.outlineBorder,
      ),
      icon: Icon(Icons.keyboard_arrow_down, size: 25, color: MyColors.grey,),
      value: _chosenGender,
      items: _genderList
          .map(
            (item) => DropdownMenuItem(
          child: Text('$item'),
          value: item,
        ),
      )
          .toList(),
      onChanged: widget.onChanged ?? (val) {
        setState(() {
          _chosenGender = val.toString();
        });
      },
      onSaved: widget.onSaved,
    );
  }
}
