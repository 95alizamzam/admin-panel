import 'package:flutter/material.dart';
import 'package:marketing_admin_panel/utils/constants.dart';

class RowElement extends StatelessWidget {
  const RowElement({
    Key? key,
    required this.label,
    required this.userImage,
    required this.userName,
  }) : super(key: key);

  final String userImage, userName, label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade100,
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                label,
                style: Constants.TEXT_STYLE4,
              ),
            ),
            Row(
              children: [
                Image(
                  image: NetworkImage(userImage),
                  width: 80,
                  height: 80,
                ),
                const SizedBox(width: 20),
                Text(
                  userName,
                  style: Constants.TEXT_STYLE4,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
