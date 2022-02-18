import 'package:flutter/material.dart';
import 'package:marketing_admin_panel/UI/categories_tab/widgets/modalSheetContent.dart';
import 'package:marketing_admin_panel/utils/colors.dart';

class TopRow extends StatelessWidget {
  const TopRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Available Categories',
            style: TextStyle(
              color: MyColors.secondaryColor,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => showaddCategorySheet(context),
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue,
            ),
            child: Row(
              children: const [
                Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 24,
                ),
                SizedBox(width: 10),
                Text(
                  'Add New Category',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void showaddCategorySheet(context) {
  showModalBottomSheet(
    shape: const OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    context: context,
    builder: (_) {
      return const ModalContent();
    },
  );
}
