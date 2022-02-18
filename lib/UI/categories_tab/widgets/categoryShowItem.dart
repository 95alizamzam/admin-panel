import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/bloc/category_bloc/change_bloc.dart';
import 'package:marketing_admin_panel/bloc/category_bloc/events.dart';
import 'package:marketing_admin_panel/utils/colors.dart';

class CategoryShowItem extends StatelessWidget {
  const CategoryShowItem({
    Key? key,
    required this.categoryTitle,
    required this.clr,
    required this.count,
    required this.ontap,
  }) : super(key: key);

  final String categoryTitle;
  final int count;
  final Color clr;
  final Function ontap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () => ontap(),
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / count,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: clr,
            ),
            child: Text(
              categoryTitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    'Delete Category !!',
                    style: TextStyle(color: Colors.red),
                  ),
                  content: Container(
                    child: const Text(
                      'Do You Want Delete this Category',
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        BlocProvider.of<CategoryBloc>(context)
                            .add(RemoveCategoryEvent(categoryTitle));

                        BlocProvider.of<CategoryBloc>(context)
                            .add(FetchAllCategoriesEvent());
                      },
                      child: const Text(
                        'Okay',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: const CircleAvatar(
              radius: 25,
              backgroundColor: MyColors.primaryColor,
              child: Icon(
                Icons.delete_forever_outlined,
                color: Colors.black,
                size: 35,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
