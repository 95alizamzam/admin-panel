import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketing_admin_panel/bloc/category_bloc/change_bloc.dart';
import 'package:marketing_admin_panel/bloc/category_bloc/events.dart';
import 'package:marketing_admin_panel/utils/colors.dart';
import 'package:marketing_admin_panel/utils/constants.dart';
import 'package:marketing_admin_panel/utils/navigator/navigator_imp.dart';

class CategoryShowItem extends StatelessWidget {
  const CategoryShowItem({
    Key? key,
    required this.categoryTitle,
    required this.clr,
    required this.count,
    required this.onTap,
  }) : super(key: key);

  final String categoryTitle;
  final int count;
  final Color clr;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () => onTap(),
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: MyColors.secondaryColor,
            ),
            child: Text(
              categoryTitle,
              style: Constants.TEXT_STYLE8.copyWith(color: Colors.white),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: () async {
              bool b = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    'Are you sure?',
                    style: Constants.TEXT_STYLE8,
                  ),
                  content: Container(
                    child: Text(
                      'This category and all its data will be deleted',
                      style: Constants.TEXT_STYLE4.copyWith(color: Colors.red),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => NavigatorImpl().pop(result: false),
                      child: const Text('Cancel', style: TextStyle(color: MyColors.secondaryColor),),
                    ),
                    TextButton(
                      onPressed: () {
                        NavigatorImpl().pop(result: true);
                      },
                      child: const Text(
                        'Okay',
                        style: TextStyle(color: MyColors.secondaryColor),
                      ),
                    ),
                  ],
                ),
              );

              if(b){
                BlocProvider.of<CategoryBloc>(context).add(RemoveCategoryEvent(categoryTitle));

                BlocProvider.of<CategoryBloc>(context).add(FetchAllCategoriesEvent());
              }

            },
            child: SvgPicture.asset('assets/images/trash.svg', fit: BoxFit.scaleDown,),
          ),
        ),
      ],
    );
  }
}
