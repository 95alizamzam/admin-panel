import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marketing_admin_panel/UI/categories_tab/widgets/categoryShowItem.dart';
import 'package:marketing_admin_panel/bloc/category_bloc/change_bloc.dart';
import 'package:marketing_admin_panel/bloc/category_bloc/events.dart';
import 'package:marketing_admin_panel/models/categories_model.dart';
import 'package:marketing_admin_panel/utils/constants.dart';

class CategoriesShow extends StatelessWidget {
  const CategoriesShow({Key? key, required this.items}) : super(key: key);
  final List<CategoryModel> items;
  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? const Center(
            child: Text(
              'There is No Categories yet',
              style: Constants.TEXT_STYLE9,
            ),
          )
        : ListView.separated(
            padding: const EdgeInsets.all(12),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CategoryShowItem(
                  count: items.length,
                  categoryTitle: items[index].title!,
                  clr: Colors.primaries[index],
                  onTap: () {
                    BlocProvider.of<CategoryBloc>(context).add(ChangeCategoryEvent(index),
                    );
                  });
            },
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemCount: items.length,
          );
  }
}
