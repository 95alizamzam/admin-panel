import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:marketing_admin_panel/UI/categories_tab/widgets/modalSheetContent.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';

class TopRow extends StatelessWidget {
  const TopRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Available Categories',
          style: Constants.TEXT_STYLE2.copyWith(fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => showAddCategorySheet(context),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: MyColors.secondaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 24,
                ),
                Text(
                  'Add New Category',
                  style: Constants.TEXT_STYLE4.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void showAddCategorySheet(context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(12),
        topLeft: Radius.circular(12),
      ),
    ),
    builder: (ctx) {
      return const ModalContent();
    },
  );
}
