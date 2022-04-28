import 'package:flutter/material.dart';
import 'package:marketing_admin_panel/utils/constants.dart';

class UserInfoRow extends StatelessWidget {
  final title;
  final icon;
  final data;
  final bool flexible;

  UserInfoRow({
    required this.data,
    required this.title,
    required this.icon,
    this.flexible = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon,
        const SizedBox(
          width: 8,
        ),
        Text(
          '$title',
          style: Constants.TEXT_STYLE9,
        ),
        const SizedBox(
          width: 12,
        ),
        if (flexible)
          Flexible(
            child: Text(
              '$data',
              overflow: TextOverflow.visible,
              style: Constants.TEXT_STYLE8,
            ),
          )
        else
          Text(
            '$data',
            style: Constants.TEXT_STYLE8,
          ),
      ],
    );
  }
}