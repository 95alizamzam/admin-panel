import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/UI/categories_tab/widgets/categoryShowItem.dart';
import 'package:marketing_admin_panel/bloc/category_bloc/change_bloc.dart';
import 'package:marketing_admin_panel/bloc/category_bloc/events.dart';
import 'package:marketing_admin_panel/models/categories_model.dart';
import 'package:marketing_admin_panel/utils/colors.dart';

class CategoriesShow extends StatelessWidget {
  const CategoriesShow({Key? key, required this.items}) : super(key: key);
  final List<CategoryModel> items;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: items.isEmpty
          ? const Center(
              child: Text(
                'There is No Categories yet',
                style: TextStyle(
                  fontSize: 30,
                  color: MyColors.secondaryColor,
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CategoryShowItem(
                    count: items.length,
                    categoryTitle: items[index].title!,
                    clr: Colors.primaries[index],
                    ontap: () {
                      BlocProvider.of<CategoryBloc>(context).add(
                        ChangeCategoryEvent(index),
                      );
                    });
              },
              separatorBuilder: (context, index) => const SizedBox(width: 20),
              itemCount: items.length,
            ),
    );
  }
}
