import 'package:flutter/material.dart';
import 'package:marketing_admin_panel/utils/constants.dart';
import 'package:marketing_admin_panel/utils/shared_widgets.dart';

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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade100,
      ),
      padding: const EdgeInsets.all(10),
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
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              userImage == ""
                  ? SharedWidgets.defaultImage()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image(
                        image: NetworkImage(userImage),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
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
    );
  }
}
